DROP TABLE IF EXISTS studentMember;
DROP TABLE IF EXISTS staffMember;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS memberCourse;
DROP TABLE IF EXISTS uniPage;
DROP TABLE IF EXISTS content;
DROP TABLE IF EXISTS section;

CREATE TABLE studentMember(
    studentID   CHAR(8) UNIQUE  NOT NULL,
    memberID    INTEGER         PRIMARY KEY AUTOINCREMENT,
    completedCourses    VARCHAR(2000),
    FOREIGN KEY (memberID) REFERENCES member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE staffMember(
    staffID     CHAR(6) UNIQUE  NOT NULL,
    memberID    INTEGER         PRIMARY KEY AUTOINCREMENT,
    isAdmin    INTEGER         DEFAULT 0,
    FOREIGN KEY (memberID) REFERENCES member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE degree (
    degreeID   INTEGER         PRIMARY KEY AUTOINCREMENT,
    degreeName  VARCHAR(100)   UNIQUE
);

CREATE TABLE member (
    memberID    INTEGER         PRIMARY KEY AUTOINCREMENT,
    firstName   VARCHAR(50)     NOT NULL,
    lastName    VARCHAR(25)     NOT NULL,
    pword       VARCHAR(20)     NOT NULL,
    degreeID    INTEGER NULL    REFERENCES degree(degreeID),
    phNumber    VARCHAR(20),
    email       VARCHAR(200)    UNIQUE  NOT NULL    
);

CREATE TABLE course (
    courseID   INTEGER         PRIMARY KEY AUTOINCREMENT,
    degreeID   INTEGER         NULL        REFERENCES degree(degreeID),
    courseName  VARCHAR(100)   UNIQUE
);

CREATE TABLE memberCourse (
    memberID      INTEGER       NOT NULL,
    courseID      INTEGER       NOT NULL,
    enrolled      BOOLEAN,
    completed     BOOLEAN,
    PRIMARY KEY (memberID, courseID),
    FOREIGN KEY (memberID)      REFERENCES member(memberID),
    FOREIGN KEY (courseID)      REFERENCES course(courseID)
);

CREATE TABLE question(
    questionID  INTEGER         PRIMARY KEY AUTOINCREMENT,
    authorID    INTEGER         NOT NULL,
    created     TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title       VARCHAR(25)     NOT NULL,
    body        VARCHAR(250)    NOT NULL,
    FOREIGN KEY (authorID)     REFERENCES member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO member VALUES('1', 'test', 'testington', 'test', '', 'test', 'test@test.com');
INSERT INTO question VALUES('2', '1', '', 'Bachelor of IT', 'Test body part here hello test.'),
('3', '1', '', 'Hello', 'hello world this major project is working now.');

CREATE TABLE uniPage(
    pageID  INTEGER NOT NULL,
    pageName            VARCHAR(50)    NOT NULL,
    PRIMARY KEY (pageID)
);


CREATE TABLE content(
    pageID              INTEGER        NOT NULL,
    contentID           INTEGER        NOT NULL,
    contentHead         VARCHAR(50)    NOT NULL,
    PRIMARY KEY (contentID),
    FOREIGN KEY (pageID) REFERENCES uniPage(pageID) ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE section(
    sectionID           INTEGER         NOT NULL,
    contentID           INTEGER         NOT NULL,
    sectionSubTitle     VARCHAR(50)     NOT NULL,
    sectionDescription  VARCHAR(4000)   NOT NULL,
    PRIMARY KEY (sectionID),
    FOREIGN KEY (contentID) REFERENCES content(contentID) ON UPDATE CASCADE ON DELETE NO ACTION
);




INSERT INTO uniPage VALUES ('1', 'Campus Services'),
('2', 'Study Essentials'),
('3', 'Home');

INSERT INTO content VALUES ('1', '1', 'Your Safety On Campus:'),
('1', '2', 'Get in contact with us!'),
('2', '3', 'Your First Day'),
('2', '4', 'Your Degree'),
('2', '5', 'What a typical semester looks like'),
('2', '6', 'Second Hand Textbooks'),
('2', '7', 'Exam Advice'),
('3', '8', 'Campus Services'),
('3', '9', 'Study Essentials'),
('3', '10', 'Frequently Asked Questions');

INSERT INTO section VALUES ('1', '1', 'Night Security Shuttle Information', 'This service is available on all campuses and can be arranged for pickup by calling 4921 5888. It can be used to get between buildings and vehicles or to the Railway Station on request.'),
('2', '1', 'Safe Walk Service', 'Call 4921 5888 or email security-services@newcastle.edu.au The service provided will escort you from building to building or building to vehicle and vice versa, within the boudnaries of the campus.'),
('3', '1', 'Smart Paths', 'For when travelling campus alone, there are certain paths that are very well lit with enhanced lighting, CCTV surveillance, extra wide paths and reduced surrounding vegetation.'),
('4', '2', 'General and Student Enquiries', 'Phone: 1300 ASK UON or +61 2 4921 5000 Enquire online: <a href="https://askuon-future.newcastle.edu.au/app/ask">AskUON'),
('5', '2', 'Central Coast', ' Phone: +61 2 4348 4000<br> Fax: +61 2 4348 4035<br> Enquire online: <a href="https://askuon-future.newcastle.edu.au/app/ask">AskUON'),
('6', '3', 'O-Week', 'O Week is a great way to get involved in activities with your soon-to-be fellow cohort. It is generally held the week before the Uni Semester starts or Week 1, hence the name "O week". You can check out all the student clubs so that you can meet people with similar interests.'),
('7', '3', 'Program Sessions', 'Orientation also involves attending your program session, where you will receive information about how your degree is structured, some things to expect from it, as well as some tips on how to successfully nail Uni! You will also be able to pick up your student card, which grants you access to the library, your library account, many other Uni services our required identification when sitting for your exams.'),
('8', '4', 'Where to get program advice', 'Your Academic Program Advisor has detailed knowledge about the requirements of your program. They can assist you with program variations due to changes in your circumstances and changes within your program. The best way to contact your Academic Program Advisor is via email: ProgramAdvice@newcastle.edu.au Academic Program Advisors are also accessible via Student Central on campus and  appointments can be made for more detailed advice.'),
('9', '5', '', 'Studying at university means you’ll have complete freedom to plan out your study timetable and complete assignments in your own time. There are plenty of ways you can reach out for guidance and support throughout your degree, especially when you are feeling overwhelmed.'),
('10', '5', 'Your First Semester Roadmap', '1. Set yourself up for your studies with our guide for new students. Find out what you need to know, from planning your course to logging into University systems.'),
('11', '6', '', 'Your Course Coordinators and Lecturers will supply you with a list of the textbooks, readings and other resources that are prescribed for your courses at your first lecture/class.'),
('12', '7', 'Where to get program advice', 'Preparation is the key to a successful exam period, so make sure you’ve got your dates and times locked in, then plan your study based on that information. As for the best ways to study for exams, UON’s Centre for Teaching and Learning has some handy pointers: <br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0006/333807/Top-tips-for-studying-for-exams-lv-from-web.pdf">Tips for studying for exams</a> <br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0011/333758/Exam-Strategies-lv-from-web.pdf">Exam Strategies</a><br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0003/355692/LD-resource-sheet-open-book-exams-how-to-build-a-memory-aid.pdf">How to build a memory aid</a><br>'),
('13', '7', 'Memory Aids', 'The University of Newcastle has an open book policy for exams. Except for some exemptions, the memory aid is the minimum allowed for exams, but some courses will allow for more than the memory aid. Always check your course outlines so that you know exactly what you can bring into each exam.  Unless stated otherwise, a memory aid is 1 x A4 double-sided sheet of any type of notes, handwritten or otherwise. It can be on coloured paper and can contain diagrams.  What to bring: Most importantly, your Student ID, Driver''s License or passport to all exams, Pens or pencils, Erasers, A clear water bottle, Tissues'),
('14', '8', '', 'Click here to go to our campus services page and find out all the amazing services that Newcastle University has to offer!'),
('15', '5', '', '2. Check out our libraries. Our expert librarians can assist you with all aspects of research and learning.'),
('16', '5', '', '3. Book a workshop. Newcastle University''s NUPrep offers FREE academic preparation and support for all University of Newcastle Students in the weeks leading up to each semester. Our courses will introduce you to learning content and completing assessment items in a similar format to your Undergraduate or Enabling Pathways program.'),
('17', '5', '', '4. Seminars on a range of skills, including academic writing, how to research and plan an essay, and how to take better notes in class.'),
('18', '5', '', '5. Get active with Newcastle Uni Sports & the Gym. You don’t need to splurge on a gym membership to get moving. Our gym facilities are free to use for University students or you can select to join in on our group sports!'),
('19', '6', '', 'We strongly encourage students to wait for their first class for their lecturers to inform them of the appropriate textbooks as they may have change or may require different ones.'),
('20', '6', '', 'From here you can choose to purchase the text online, from a book store, or from online second hand textbook sites.');




