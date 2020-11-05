from flask import(
    Blueprint, flash, g, redirect, render_template, request, url_for, jsonify
)

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db
# Don't know if this is needed
# import sqlite3
# Think need to replace schema with actual db file
# conn = sqlite3.connect('schema.sql')

bp = Blueprint('blog', __name__)

@bp.route('/questions')
def questions():
    db = get_db()
    questions = db.execute(
        'SELECT q.questionID, title, body, created, authorID, firstName'
        ' FROM question q JOIN member m ON q.authorID = m.memberID'
        ' ORDER BY created DESC'
    ).fetchall()
    member = db.execute(
        'SELECT * FROM member'
        ).fetchall()
    return render_template('blog/questions.html', questions=questions, member=member)


@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        error = None

        if not title:
            error = 'Title is required.'

        if error is not None:
            flask(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO question (title, body, authorID)'
                'VALUES (?, ?, ?)',
                (title, body, g.member['memberID'])
            )
            db.commit()
            return redirect(url_for('blog.index'))
    return render_template('blog/create.html')

def get_question(questionID, check_author=True):
    question = get_db().execute(
        'SELECT q.questionID, title, body, created, authorID, email'
        ' FROM question q JOIN member m ON q.authorID = m.memberID'
        ' WHERE q.questionID = ?',
        (questionID,)
    ).fetchone()

    if question is None:
        abort(404, "Question id {0} doesn't exist.".format(questionID))

    if check_author and question['authorID'] != g.member['memberID']:
        abort(403)

    return question

@bp.route('/<int:id>/update', methods=('GET', 'POST'))
@login_required
def update(id):
    question = get_question(id)

    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        error = None

        if not title:
            error = 'Title is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'UPDATE question SET title = ?, body = ?'
                'WHERE id = ?',
                (title, body, id)
            )
            db.commit()
            return redirect(url_for('blog.index'))
    return render_template('blog/update.html', question=question)

@bp.route('/<int:id>/delete', methods=('POST',))
@login_required
def delete(id):
    get_question(id)
    db = get_db()
    db.execute('DELETE FROM question WHERE id = ?', (id,))
    db.commit()
    return redirect(url_for('blog.index'))

