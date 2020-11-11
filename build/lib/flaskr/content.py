from flask import(
    Blueprint, flash, g, redirect, render_template, request, url_for, jsonify
)

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db



def get_content(questionID, check_author=True):
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