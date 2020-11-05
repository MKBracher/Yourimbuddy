from flask import(
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db
from django import forms



bp = Blueprint('general', __name__, template_folder='templates')




@bp.route('/')
def index():
    return render_template('general/index.html')

@bp.route('/services', methods=('GET', 'POST'))
def campusServices():
    return render_template('general/campusServices.html')


@bp.route('/essentials', methods=('GET', 'POST'))
def studyEssentials():
    return render_template('general/studyEssentials.html')
    
@bp.route('/FAQ', methods=('GET', 'POST'))
def FAQ():
    return render_template('general/FAQ.html')

@bp.route('/account', methods=('GET', 'POST'))
@login_required
def account():
    db = get_db()
    member = db.execute(
        'SELECT * FROM member'
        ).fetchall()
    return render_template('general/account.html', current_user = member)



# searchbar stuff
# @bp.route('/searchindex')
# def searchindex():
#     posts = Post.query.all()
#     return render_template('searchindex.html', posts=posts)


@bp.route('/search_results/<query>', methods=['GET', 'POST'])
def search_results(query):
    qvar = request.form['query']
    db = get_db()
    error = None
    results = db.execute(
        'SELECT * FROM content WHERE sectionName LIKE "%{}%" or "sectionTitle LIKE "%{}%" or "sectionDescription LIKE "%{}%"'.format(qvar, qvar, qvar)
    ).fetchall()
    return render_template('general/search_results.html', query=query, results=results)