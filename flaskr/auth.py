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
        password = request.form['password']
        stdID = request.form['stdID']
        firstName = request.form['firstName']
        lastName = request.form['lastName']
        degree = request.form['degree']
        course = request.form['course']
        phNumber = request.form['phNumber']
        is_admin = request.form.get('is_admin')
        db = get_db()
        error = None

        if not email:
            error = 'Email is required.'
        elif not password:
            error = 'Password is required.'
        elif not stdID:
            error = 'Student ID is required'
        elif not firstName:
            error = 'First name is required'
        elif not lastName: 
            error = 'Last name is required'
        elif db.execute(
            'SELECT id FROM user WHERE email = ?', (email,)
        ).fetchone() is not None:
            error = 'User {} is already registered.'.format(email)

        if error is None:
            db.execute(
                'INSERT INTO user (email, password, stdID, firstName, lastName, degree, course, phNumber, is_admin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
                (email, generate_password_hash(password), stdID, firstName, lastName, degree, course, phNumber, is_admin))
            db.commit()
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('auth/register.html')


class RegistrationForm(Form):
    stdID = StringField('Student ID', [validators.DataRequired(), validators.length(min=8, max=8)])
    firstName = StringField('First Name', [validators.DataRequired(), validators.length(min=2, max=50)])
    lastName = StringField('Last Name', [validators.DataRequired(), validators.length(min=2, max=50)])
    email = StringField('Email Address', [validators.DataRequired(), validators.length(min=6, max=35)])
    password = PasswordField('New Password', [validators.DataRequired(), validators.EqualTo('confirm', message = 'Passwords must match')
    ])
    confirm = PasswordField('Repeat Password')
    degree = StringField('Degree', [validators.length(min=4, max=50)])
    course = StringField('Course Code', [validators.optional(), validators.length(min=4, max=30)])
    phNumber = IntegerField('Phone Number', [validators.optional()])
    is_admin = BooleanField('Admin?', [validators.DataRequired()])

# @bp.route('/Register', methods=['GET', 'POST'])
# def register():
#     form = RegistrationForm(request.form)
#     if request.method == 'POST' and form.validate():
#         user = User(form.stdID.data, form.firstName.data,form.lastName.data, form.email.data, form.password.data, form.degree.data, form.course.data, form.phNumber.data, form.is_admin.data )
#         db_session.add(user)
#         flash('Thanks for registering')
#         return redirect(url_for('login'))
#     return render_template('auth/register.html', form=form)

@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        db = get_db()
        error = None
        user = db.execute(
            'SELECT * FROM user WHERE email = ?', (email,)
        ).fetchone()

        if user is None:
            error = 'Incorrect email.'
        elif not check_password_hash(user['password'], password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user['id']
            return redirect(url_for('index'))

        flash(error)

    return render_template('auth/login.html')

@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        g.user = get_db().execute(
            'SELECT * FROM user WHERE id = ?', (user_id,)
        ).fetchone()


@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view