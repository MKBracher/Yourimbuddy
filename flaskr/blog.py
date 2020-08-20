from flask import(
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db

bp = Blueprint('blog', __name__)

@bp.route('/')
def index():
    db = get_db()
    questions = db.execute(
        'SELECT q.id, title, body, created, author_id, email'
        ' FROM question q JOIN user u ON q.author_id = u.id'
        ' ORDER BY created DESC'
    ).fetchall()
    return render_template('blog/index.html', questions=questions)


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
                'INSERT INTO question (title, body, author_id)'
                'VALUES (?, ?, ?)',
                (title, body, g.user['id'])
            )
            db.commit()
            return redirect(url_for('blog.index'))
    return render_template('blog/create.html')

def get_question(id, check_author=True):
    question = get_db().execute(
        'SELECT q.id, title, body, created, author_id, email'
        ' FROM question q JOIN user u ON q.author_id = u.id'
        ' WHERE q.id = ?',
        (id,)
    ).fetchone()

    if question is None:
        abort(404, "Question id {0} doesn't exist.".format(id))

    if check_author and question['author_id'] != g.user['id']:
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