import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)

from wtforms import Form, BooleanField, StringField, PasswordField, validators, IntegerField

from werkzeug.security import check_password_hash, generate_password_hash

from flaskr.db import get_db

bp = Blueprint('auth', __name__, url_prefix='/auth')

@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        email = request.form['email']
        pword = request.form['pword']
        studentID = request.form['studentID']
        firstName = request.form['firstName']
        lastName = request.form['lastName']
        degreeID = request.form['degree']
        courseID = request.form['course']
        phNumber = request.form['phNumber']
        isAdmin = request.form.get('isAdmin')
        db = get_db()
        error = None

        if not email:
            error = 'Email is required.'
        elif not pword:
            error = 'Password is required.'
        elif not studentID:
            error = 'Student ID is required'
        elif not firstName:
            error = 'First name is required'
        elif not lastName: 
            error = 'Last name is required'
        elif db.execute(
            'SELECT memberID FROM member WHERE email = ?', (email,)
        ).fetchone() is not None:
            error = 'Member {} is already registered.'.format(email)

        if error is None:
            db.execute(
                'INSERT INTO member (email, pword, firstName, lastName, degreeID, phNumber) VALUES (?, ?, ?, ?, ?, ?)',
                (email, generate_password_hash(pword), firstName, lastName, degreeID, phNumber))
            db.commit()
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('auth/register.html')


class RegistrationForm(Form):
    studentID = StringField('Student ID', [validators.DataRequired(), validators.length(min=8, max=8)])
    firstName = StringField('First Name', [validators.DataRequired(), validators.length(min=2, max=50)])
    lastName = StringField('Last Name', [validators.DataRequired(), validators.length(min=2, max=50)])
    email = StringField('Email Address', [validators.DataRequired(), validators.length(min=6, max=35)])
    pword = PasswordField('New Password', [validators.DataRequired(), validators.EqualTo('confirm', message = 'Passwords must match')
    ])
    confirm = PasswordField('Repeat Password')
    degree = StringField('Degree', [validators.length(min=4, max=50)])
    course = StringField('Course Code', [validators.optional(), validators.length(min=4, max=30)])
    phNumber = IntegerField('Phone Number', [validators.optional()])
    isAdmin = BooleanField('Admin?', [validators.DataRequired()])

# @bp.route('/Register', methods=['GET', 'POST'])
# def register():
#     form = RegistrationForm(request.form)
#     if request.method == 'POST' and form.validate():
#         member = Member(form.studentID.data, form.firstName.data,form.lastName.data, form.email.data, form.password.data, form.degree.data, form.course.data, form.phNumber.data, form.isAdmin.data )
#         db_session.add(member)
#         flash('Thanks for registering')
#         return redirect(url_for('login'))
#     return render_template('auth/register.html', form=form)

@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        email = request.form['email']
        pword = request.form['pword']
        db = get_db()
        error = None
        member = db.execute(
            'SELECT * FROM member WHERE email = ?', (email,)
        ).fetchone()

        if member is None:
            error = 'Incorrect email.'
        elif not check_password_hash(member['pword'], pword):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['member_id'] = member['memberID']
            return redirect(url_for('index'))

        flash(error)

    return render_template('auth/login.html')

@bp.before_app_request
def load_logged_in_member():
    member_id = session.get('member_id')

    if member_id is None:
        g.member = None
    else:
        g.member = get_db().execute(
            'SELECT * FROM member WHERE memberID = ?', (member_id,)
        ).fetchone()


@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.member is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view

