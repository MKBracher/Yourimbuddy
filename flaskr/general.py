from flask import(
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db



bp = Blueprint('general', __name__, template_folder='templates')




@bp.route('/')
def index():
    return render_template('general/index.html')

@bp.route('/services', methods=('GET', 'POST'))
def campusServices():
    db = get_db()
    contents = db.execute(
        'SELECT * \
        FROM content\
        WHERE pageID = "1"'
    )
    pages = db.execute(
        'Select * \
        FROM uniPage \
        WHERE pageID = "1"'
    )
    sections = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID IN ("1", "2")')
    sections2 = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID = "2"')
    
    return render_template('general/campusServices.html', contents=contents, pages=pages, sections=sections, sections2=sections2)


@bp.route('/essentials', methods=('GET', 'POST'))
def studyEssentials():
    db = get_db()
    contents = db.execute(
        'SELECT * \
        FROM content\
        WHERE pageID = "2"'
    )
    pages = db.execute(
        'Select * \
        FROM uniPage \
        WHERE pageID = "2"'
    )
    
    sections3 = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID = "3"')
    
    sections4 = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID = "4"')
    sections5 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "5"'
    )
    sections6 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "6"'
    )
    sections7 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "7"'
    )
    return render_template('general/studyEssentialsDB.html',contents=contents, pages=pages, sections4=sections4, sections3=sections3, sections5=sections5, sections6=sections6, sections7=sections7)
    
@bp.route('/FAQ', methods=('GET', 'POST'))
def FAQ():
    db = get_db()
    contents = db.execute(
        'SELECT * \
        FROM content\
        WHERE pageID = "4"'
    )
    pages = db.execute(
        'Select * \
        FROM uniPage \
        WHERE pageID = "4"'
    )
    
    sections11 = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID = "11"')
    
    sections12 = db.execute(
        'SELECT * \
        FROM section \
        WHERE contentID = "12"')
    sections13 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "13"'
    )
    sections14 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "14"'
    )
    sections15 = db.execute(
       'SELECT * \
       FROM section \
       WHERE contentID = "15"'
    )
    return render_template('general/FAQDB.html', contents=contents, pages=pages, sections11=sections11, sections12=sections12, sections13=sections13, sections14=sections14, sections15=sections15)

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