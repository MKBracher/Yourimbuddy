


import sqlite3, requests
from sqlite3 import Error




def create_connection(db_file):
    
    conn = None
    try:
        conn = sqlite3.connect(flaskr.sqlite)
    except Error as e:
        print(e)

    return conn


def select_all_content(conn):

    cur = conn.cursor()
    cur.execute("SELECT * FROM content")

    rows = cur.fetchall()

    for row in rows:
        print(row)

def select_content_by_priority(conn, priority):
    
    cur = conn.cursor()
    cur.execute("SELECT * FROM content WHERE ", (priority,))

    rows = cur.fetchall()

    for row in rows:
        print(row)


def main():
    # placeholder path
    database = r"flaskr.sqlite"

    conn = create_connection(database)
    with conn:
        print("1. Query content by priority:")
        select_content_by_priority(conn, 1)

        print("2. Query all content")
        select_all_content(conn)


if __name__ == '__main__':
    main()


# searchdata = requests.get('')