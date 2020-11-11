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



CREATE TABLE member (
    memberID    INTEGER         PRIMARY KEY AUTOINCREMENT,
    firstName   VARCHAR(50)     NOT NULL,
    lastName    VARCHAR(25)     NOT NULL,
    pword       VARCHAR(20)     NOT NULL,
    degreeID    INTEGER NULL,
    phNumber    VARCHAR(20),
    email       VARCHAR(200)    UNIQUE  NOT NULL,
    FOREIGN KEY (degreeID) REFERENCES degree(degreeID) ON UPDATE CASCADE ON DELETE NO ACTION    
);

CREATE TABLE degree (
    degreeID   INTEGER         PRIMARY KEY AUTOINCREMENT,
    degreeName  VARCHAR(100)   UNIQUE
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
    sectionSubTitle     VARCHAR(200)     NOT NULL,
    sectionDescription  VARCHAR(4000)   NOT NULL,
    PRIMARY KEY (sectionID),
    FOREIGN KEY (contentID) REFERENCES content(contentID) ON UPDATE CASCADE ON DELETE NO ACTION
);




INSERT INTO uniPage VALUES ('1', 'Campus Services'),
('2', 'Study Essentials'),
('3', 'Home'),
('4', 'Frequently Asked Questions');

INSERT INTO content VALUES ('1', '1', 'Your Safety On Campus:'),
('1', '2', 'Get in contact with us!'),
('2', '3', 'Your First Day'),
('2', '4', 'Your Degree'),
('2', '5', 'What a typical semester looks like'),
('2', '6', 'Second Hand Textbooks'),
('2', '7', 'Exam Advice'),
('3', '8', 'Campus Services'),
('3', '9', 'Study Essentials'),
('3', '10', 'Frequently Asked Questions'),
('4', '11', 'Applying to UON'),
('4', '12', 'Starting at UON'),
('4', '13', 'Student Essentials'),
('4', '14', 'Student Services and Support'),
('4', '15', 'Uni Life'),
('1', '16', 'Parking');

INSERT INTO section VALUES ('1', '1', 'Night Security Shuttle Information', 'This service is available on all campuses and can be arranged for pickup by calling 4921 5888. It can be used to get between buildings and vehicles or to the Railway Station on request.'),
('2', '1', 'Safe Walk Service', 'Call 4921 5888 or email security-services@newcastle.edu.au The service provided will escort you from building to building or building to vehicle and vice versa, within the boudnaries of the campus.'),
('3', '1', 'Smart Paths', 'For when travelling campus alone, there are certain paths that are very well lit with enhanced lighting, CCTV surveillance, extra wide paths and reduced surrounding vegetation.'),
('4', '2', 'General and Student Enquiries', 'Phone: 1300 ASK UON or +61 2 4921 5000<br>Enquire online: <a href="https://askuon-future.newcastle.edu.au/app/ask">AskUON</a>'),
('5', '2', 'Central Coast', ' Phone: +61 2 4348 4000<br> Fax: +61 2 4348 4035<br> Enquire online: <a href="https://askuon-future.newcastle.edu.au/app/ask">AskUON</a>'),
('6', '3', 'O-Week', 'O Week is a great way to get involved in activities with your soon-to-be fellow cohort. It is generally held the week before the Uni Semester starts or Week 1, hence the name "O week". You can check out all the student clubs so that you can meet people with similar interests.'),
('7', '3', 'Program Sessions', 'Orientation also involves attending your program session, where you will receive information about how your degree is structured, some things to expect from it, as well as some tips on how to successfully nail Uni! You will also be able to pick up your student card, which grants you access to the library, your library account, many other Uni services our required identification when sitting for your exams.'),
('8', '4', 'Where to get program advice', 'Your Academic Program Advisor has detailed knowledge about the requirements of your program. They can assist you with program variations due to changes in your circumstances and changes within your program. The best way to contact your Academic Program Advisor is via email: ProgramAdvice@newcastle.edu.au Academic Program Advisors are also accessible via Student Central on campus and  appointments can be made for more detailed advice.'),
('9', '5', '', 'Studying at university means you’ll have complete freedom to plan out your study timetable and complete assignments in your own time. There are plenty of ways you can reach out for guidance and support throughout your degree, especially when you are feeling overwhelmed.'),
('10', '5', 'Your First Semester Roadmap', 'Set yourself up for your studies with our guide for new students. Find out what you need to know, from planning your course to logging into University systems.'),
('11', '6', '', 'Your Course Coordinators and Lecturers will supply you with a list of the textbooks, readings and other resources that are prescribed for your courses at your first lecture/class.'),
('12', '7', 'Where to get program advice', 'Preparation is the key to a successful exam period, so make sure you’ve got your dates and times locked in, then plan your study based on that information. As for the best ways to study for exams, UON’s Centre for Teaching and Learning has some handy pointers: <br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0006/333807/Top-tips-for-studying-for-exams-lv-from-web.pdf">Tips for studying for exams</a> <br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0011/333758/Exam-Strategies-lv-from-web.pdf">Exam Strategies</a><br> <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0003/355692/LD-resource-sheet-open-book-exams-how-to-build-a-memory-aid.pdf">How to build a memory aid</a><br>'),
('13', '7', 'Memory Aids', 'The University of Newcastle has an open book policy for exams. Except for some exemptions, the memory aid is the minimum allowed for exams, but some courses will allow for more than the memory aid. Always check your course outlines so that you know exactly what you can bring into each exam.  Unless stated otherwise, a memory aid is 1 x A4 double-sided sheet of any type of notes, handwritten or otherwise. It can be on coloured paper and can contain diagrams.  What to bring: Most importantly, your Student ID, Driver''s License or passport to all exams, Pens or pencils, Erasers, A clear water bottle, Tissues'),
('14', '8', '', 'Click here to go to our campus services page and find out all the amazing services that Newcastle University has to offer!'),
('15', '5', '', 'Check out our libraries. Our expert librarians can assist you with all aspects of research and learning.'),
('16', '5', '', 'Book a workshop. Newcastle University''s NUPrep offers FREE academic preparation and support for all University of Newcastle Students in the weeks leading up to each semester. Our courses will introduce you to learning content and completing assessment items in a similar format to your Undergraduate or Enabling Pathways program.'),
('17', '5', '', 'Seminars on a range of skills, including academic writing, how to research and plan an essay, and how to take better notes in class.'),
('18', '5', '', 'Get active with Newcastle Uni Sports & the Gym. You don’t need to splurge on a gym membership to get moving. Our gym facilities are free to use for University students or you can select to join in on our group sports!'),
('19', '6', '', 'We strongly encourage students to wait for their first class for their lecturers to inform them of the appropriate textbooks as they may have change or may require different ones.'),
('20', '6', '', 'From here you can choose to purchase the text online, from a book store, or from online second hand textbook sites.'),
('21', '11', 'Does my ATAR expire and how do I find it?', 'No, your Australian Tertiary Admissions Rank (ATAR) does not expire. You can continue to use your ATAR for admission to the University of Newcastle any year after you have completed your Higher School Certificate (HSC), or Year 12/final year of school. The University of Newcastle takes your highest eligible ranked qualification into consideration for admission to the university. This means that if you have completed your HSC and have an ATAR but have also completed TAFE studies since finishing school, we will look at all of your qualifications and use the highest for admission to the university.'),
('22', '11', 'How do I apply for credit?', '<ol id="574409e3-fc56-4925-bb94-a2614d1d1596" class="numbered-list" start="1"><li>Check the <a href="https://dotnet.newcastle.edu.au/CreditTransfer/">credit transfer catalogue</a> to see if an agreement exists between your institution and UON.</li></ol><ol id="137a35f7-1299-4a42-bea4-04fbb9155095" class="numbered-list" start="2"><li>Check the <a href="https://askuon.newcastle.edu.au/app/answers/detail/a_id/1965/kw/program%20plan">program plan</a> and <a href="https://www.newcastle.edu.au/degrees">handbook</a> for your UON program to determine the courses you might be eligible to receive credit for based on previous studies .</li></ol><ol id="b4853aa3-14bc-40e7-9d08-93c0183e9589" class="numbered-list" start="3"><li>Create an online application in CATS adding in your personal and study details.</li></ol><ol id="afe17654-c0fc-4ec3-b504-64c94537c49f" class="numbered-list" start="4"><li><a href="https://askuon.newcastle.edu.au/app/answers/detail/a_id/2173/kw/2173">Map the courses</a> studied at another institution to UON courses in your <a href="https://askuon.newcastle.edu.au/app/answers/detail/a_id/1965/kw/program%20plan">program plan</a> for the program. This may be to specific courses or electives.</li></ol><ol id="a5e332e7-b34a-4da1-94a3-9549b55edaa8" class="numbered-list" start="5"><li>Upload certified documents (or clear colour file copies) including official transcripts and course outlines for each course you are seeking credit for within a program.</li></ol><ol id="d035abc5-e8c3-4d97-b43f-15b801327a86" class="numbered-list" start="6"><li>Submit the application. You will receive an email confirming that your application has been submitted.</li></ol>'),
('23', '11', 'How can I transfer from another University to the University of Newcastle?', 'To transfer from your current University to the University of Newcastle you need to apply through the Universities Admissions Centre (UAC) and be assessed as a new applicant.'),
('24', '11', 'When will offers be released to commence study in Semester 1, 2021?', 'The University of Newcastle will be making offers from August 2020 through until February 2021. The majority of offers in pre-December Rounds will be to applicants who are NOT completing high school in 2020. <br> The majority of offers to 2020 Year 12 students will be made in December Round 2, unless you are eligible under an <a href="https://askuon.newcastle.edu.au/app/answers/detail/a_id/1103">Early Offer Scheme</a>.'),
('25', '12', 'How do I enrol?', 'Enrolment is a two-part process: <ol> <li>Enrol in your course in myHub and plan your timetable.</li><li>Choose time for your class activities in Manage myTimetable in myUON.</li></ol>You can view the ''How to Enrol'' video for step by step instructions to help you enrol successfully in your courses.'),
('26', '12', 'How do I drop a course?','To drop a course so that you are no longer enrolled in this course please follow the steps below. <br> <ol> <li> You will need to log into <a href="https://myhub.newcastle.edu.au/">myHub</a></li><li>Select ''My Course Enrolment'' link</li><li>Select the Drop tab</li><li>Select the correct study term for the course. e.g. Semester One</li><li>Select the course you would like to drop from the list of courses and click drop</li><li>Select the Finishing Dropping Course.</li></ol>'),
('27', '12', 'When can I enrol in courses?', 'Enrolment for Semester 1, Trimester 1 and Trimester 2, 2020 will be opening in December. Please keep an eye on your emails for further information.'),
('28', '12', 'How do I know which courses I need to enrol in?', 'You should consult your <a href="http://askuon.custhelp.com/app/answers/detail/a_id/1713/">Program Handbook</a> and the <a href="http://askuon.custhelp.com/app/answers/detail/a_id/1966">Program Plan</a> that corresponds to the year you commenced the program. Some programs have different plans for different campuses of study or for different options (eg. One major or two majors or for graded and ungraded honours). <br>Your Program Plan provides course information and outlines the requirements of your program.You can find your program plan by: <br> <ul> <li>Logging into <a href="https://askuon-future.newcastle.edu.au/app/utils/login_form">AskUON</a> then click ''My Account'' on the right hand side then ''View My Program Plan'' or click ''View My Program Plan'' button below </li><li>You can also access your Program Plan from the <a href="https://www.newcastle.edu.au/degrees">degree handbook</a>, for your specific degree. This is located under the Program Plan link in the left hand side menu bar.</li></ul>'),
('29', '13', 'What happens if I miss an exam?', 'Failure to attend a formal examination without written approval is a very serious matter. Misreading the examination timetable will not be accepted as a reason for failing to attend an examination. You are expected to attend examinations unless circumstances beyond your control prevent you from doing so. <br>If the formal examination has been designated as a compulsory assessment and you do not attend this will normally result in a Fail grade (FF) for the course.'),
('30', '13', 'Where can I go for academic support?', 'A Student Progress Advisor can help you understand what support options are available and link you to the support that will assist you in your academic success. You can make an <a href="http://www.newcastle.edu.au/current-students/study-essentials/manage-your-program/student-progress-advice">appointment</a> with a Student Progress Advisor <ul><li> <strong>PASS sessions</strong>: <a href="http://www.newcastle.edu.au/current-students/learning/study-skills/peer-study-assistance">Peer Assisted Study Sessions</a> are run by students who have previously excelled in that course. You can ask advice from the PASS leader or your fellow students, and can work through concepts together in a group environment. </li><li><strong>Academic Learning Support</strong>: There are a team of <a href="https://www.newcastle.edu.au/current-students/support/academic/workshops-consultations-advisors">Learning Advisors</a> who work with students to develop their writing, math and communication skills. The services are free, open to all, and include group workshops and face to face, phone, skype and email appointments.</li><li><strong>Tutors, Lecturers and Course Coordinators</strong> are easily approachable, and you can find their contact details in your <a href="http://askuon.custhelp.com/app/answers/detail/a_id/2038">Course Outline</a>. They are responsible for the course content, assessments, Blackboard sites, adverse circumstances and grades. If you have any questions about lecture material, an assessment item or anything else about the course, these staff members are available to help. </li><li><strong>Program Convenor</strong>: an academic staff member with overall responsibility for the management and quality of your entire degree. Your <a href="http://askuon.custhelp.com/app/answers/detail/a_id/1685">Program Convenor</a> is a good person to contact for advice on academic matters, including career advice and course recommendations to suit your interests and study plans. Your Program Convenor is different to your <a href="http://askuon.custhelp.com/app/answers/detail/a_id/1693">Academic Program Advisor</a>, who can help you ensure that you are enrolling in the necessary courses to meet the requirements of your degree.</li></ul>'),
('31', '13', 'What support services does the University offer for students?', 'There is a wide range of student support services available to help students transition to university and get the most out of their study. <br>Our support services can provide you with assistance in the following areas:<br><ul><li>Health and Wellbeing</li><li>Meeting the Costs of Study</li><li>Program Advice</li><li>Student Life on Campus</li><li>Tools for Success</li><li>Other Topics (student living, chaplaincy, counselling, disability support, careers service etc)</li></ul><br>You may also like to check out the <a href="https://www.newcastle.edu.au/current-students/uni-life/activities-and-experiences/mentors-and-ambassadors">Peer Mentor program</a>. Peer Mentors are experienced students who understand the challenges and rewards of being a new student at the University and are here to help you settle into study at the University of Newcastle.'),
('32', '13', 'What is a Peer Writing Mentor?', '<a href="https://www.newcastle.edu.au/current-students/support/academic/learn-from-other-students">Peer Writing Mentors</a> are students who provide advice on developing your writing skills.<br>Peer Writing Mentors can:<br><ul><li>Give you advice about study skills, writing and referencing</li><li>Offer general feedback about your writing or discuss ideas and concerns with you about your work</li><li>Show you strategies for how to do something (e.g. use a referencing style, analyse a question and interpret marking criteria, structure an essay, use a writing or note taking planner)</li><li>Provide you with referral to other services, if we can’t help you.</li></ul>Writing mentors can''t correct your work but can provide advice on areas that may need improvement.<br><strong>Please note:</strong><br>Peer Writing Mentors are going <a href="https://www.newcastle.edu.au/current-students/support/academic/learn-from-other-students">online</a>! You can meet them in Zoom, 11am-2pm, Monday to Friday.'),
('33', '14', 'How do I access my NUmail account?', 'If you are a current student of the University you will have access to all our online systems including NUmail through the student portal <a href="https://myuon.newcastle.edu.au/">myUON</a>.To access your NUmail account through <a href="https://myuon.newcastle.edu.au/">myUON</a>, click on the NUmail light blue icon / tile.<br><strong>Please note:</strong> Past students can still access their student email via <a href="https://www.outlook.com/uon.edu.au">Microsoft Office 365</a>.<br>Your email address is in the format of c1234567@uon.edu.au (student number) and can be accessed using the same password as all UON computer systems.If you have lost your password, or been locked out of your account you can use the <a href="https://askuon.custhelp.com/app/answers/detail/a_id/1235/kw/lost%20password">''Forgotten Password''</a> function on the NUaccess login page.'),
('34', '14', 'Is there free software I can access as a student?', 'Yes, we provide a number of downloadable software packages for you to use for free while you are a current student of UoN, including Microsoft Office 365, EndNote, Sophos antivirus, JMP statistical software, SAS statistical software, MATLAB and NVivo.<br>The Microsoft Student Advantage Scheme enables UoN students access to digital downloads of Microsoft Office 365 on up to 5 PCs/Macs, 5 mobile devices and 5 Tablets, for ease of access anywhere, anytime on any devices. The Office 365 package includes full versions of: Microsoft Word, Excel, OneNote, OneDrive, PowerPoint, Outlook, Teams and more. As long as you are an enrolled student at UoN, the full editable version of the software will be available for you to download.<br><strong>Please note:</strong> Not all applications are available on all platforms.<br>Access to the Microsoft Student Advantage Scheme is through your <a href="https://login.microsoftonline.com/login.srf?wa=wsignin1.0&amp;rpsnv=4&amp;ct=1430788883&amp;rver=6.6.6556.0&amp;wp=MBI_SSL&amp;wreply=https:%2F%2Foutlook.office365.com%2Fowa%2F%3Frealm%3Dnewcastle.edu.au%26vd%3Dwebmail&amp;id=260563&amp;whr=newcastle.edu.au&amp;CBCXT=out">NUmail account</a>. To access the scheme, please visit <a href="https://www.newcastle.edu.au/current-students/campus-environment/information-technology/software-for-personal-use">Student Advantage Scheme</a>, where you will need to login with your student number and password to access further information and the download links.'),
('35', '14', 'How do I change my preferred email address in myHub?', 'You can select your preferred email address in myHub by following the below steps:<br><ol><li>Login to <a href="http://myhub.newcastle.edu.au/">myHub</a></li><li>Under my Personal Information, select Personal Details</li><li>Click on the Email Addresses tab</li><li>Tick the box next to your preferred email address</li><li>Click Save</li></ol><br>If you need to update your email address, add a new one or remove an old address you can do this here too.<br>You may also forward all emails from your student account to your personal email. Check the settings in Outlook for more information on how to do this.'),
('36', '14', 'How does printing work?', 'UON printing lets you use your UON ID card to release and pay for printing at any Library multifunction printer/photocopier (MFD).<br>To send printing:<br><ol><li>Select Student Print from your PC printer list. Print your job as normal, check the colour and single/double sided settings (Student Print will default to B&W/Single sided).</li><li>Click ok to send your printing. Print jobs will expire daily at 12am midnight.</li></ol><br>To release printing at the Library MFDs:<ol><li>Swipe your UON ID card and select ''My Print Jobs''.</li><li>Choose printing for release (select multiple items if required) and press ''Print''.</li><li>Collect your printing. Payment will be deducted from your account. Remember to logout.</li></ol>'),
('37', '15', 'What are the University holidays?', '<a href="https://www.newcastle.edu.au/dates">Key Dates</a> will provide you with comprehensive information on all study periods, including University holidays, recesses, teaching weeks and exam periods.<br>Current students can also view key University dates using the calendar in <a href="https://myuon.newcastle.edu.au/">myUON</a>.'),
('38', '15', 'What is expected of me as a student of the University?', 'The student expectations are:<br><ol><li>Participate and engage in all courses in which you are enrolled.</li><li>Take responsibility for your learning and accessing additional help.</li><li>Read prescribed materials and submit assessments when due.</li><li>Act ethically and honestly in the preparation and submission of all assessment items.</li><li>Consult the Program Convenor or Course Coordinator early if you''re having difficulties with a course, assessment, etc.</li><li>Respond promptly to requests for information, usually within three (3) working days.</li><li>Provide honest and constructive feedback on programs and courses.</li><li>Access your UON email account and UONline (both via <a href="https://myuon.newcastle.edu.au/">myUON</a>)).</li> <li>Recognise academic staff have multiple roles, including teaching, research and administration.</li><li>Treat other students and all staff respectfully.</li></ol>'),
('39', '15', 'What are the key university dates?', 'While the <a href="https://www.newcastle.edu.au/dates">individual dates</a> change year-to-year, there are some key dates which you should be aware of each semester.<br><ul><li><strong>Last day to add a course:</strong> this is the last day you may add a course through myHub. The last day to add a course is the second Friday of the semester. If you need to enrol after this date, you should complete an <a href="https://www.newcastle.edu.au/__data/assets/pdf_file/0016/74410/Application-for-Late-Enrolment.pdf">Application for Late Enrolment</a>, which must be approved by the Course Coordinator.</li><li><strong><a href="http://www.newcastle.edu.au/current-students/support/fees-and-scholarships/census-dates">Census Date:</strong></a> this is the last day you may withdraw from a course without being financially liable (having to pay). This is also the last day that eligible students may submit their request for HECS-HELP to defer their tuition fees. This is also the last day to submit an SA-HELP eCAF to defer your Student Services and Amenities Fee (SSAF). You can access the HECS-HELP and SA-HELP request in <a href="http://myhub.newcastle.edu.au/">myHub</a>. You can view your other payment options at <a href="http://www.newcastle.edu.au/current-students/support/fees-and-scholarships/fee-payment">Fee Payment</a>.</li><li><strong>Last day to withdraw from a course:</strong> this is the last day you can <a href="http://askuon.custhelp.com/app/answers/detail/a_id/710">withdraw from a course</a> without academic penalty. This is the last Friday of the semester. Your enrolment in the course will not appear on your Official Academic Transcript, however you will be financially liable for the course (you may apply for a <a href="http://askuon.custhelp.com/app/answers/detail/a_id/496">remission or refund in extenuating circumstances</a>).</li><li><strong>Examinations:</strong> There is a <a href="http://www.newcastle.edu.au/current-students/learning/assessments-and-exams/exam-dates-and-timetables">formal exam period</a> which runs for three weeks commencing at the conclusion of each semester. You will be informed of your examination timetable around Week 9 via email sent to your <a href="https://sso.newcastle.edu.au/cas/login?service=https%3A%2F%2Fmyuon.newcastle.edu.au%2Fpaf%2Fauthorize">NUmail</a>.</li><li><strong><a href="http://www.newcastle.edu.au/current-students/learning/assessments-and-exams/course-results-and-dates">Fully Graded Date</a></strong> This is the day that your semester results are released. You will not be able to access your grades if you have any holds on your record, including the Academic Integrity Module, library fines, or miscellaneous fees, visit <a href="http://askuon.custhelp.com/app/answers/detail/a_id/1425">What can I do to ensure I can view my grades when results are released on Fully Graded Date?</a></li></ul>'),
('40', '15', 'How can I purchase textbooks?', 'Your Course Coordinators and Lecturers will supply you with a list of the textbooks, readings and other resources that are prescribed for your courses at your first lecture/class. You can purchase prescribed texts from the <a href="https://theschoollocker.com.au/universities/the-university-of-newcastle">School Locker</a> (Callaghan) which is now open for trading in the Shortland building.<br>Searching courses via <a href="https://theschoollocker.com.au/universities/the-university-of-newcastle">School Locker</a> is an easy way to search and buy your text books. Please note these lists are as accurate as possible but you should check your Course Outline for texts to make sure you are purchasing the correct edition.<br>In addition to the School Locker the following options are available:<br><ul><li>Take a look at notice boards on campus for any textbooks for sale.</li><li>Visit <a href="https://studentvip.com.au/textbooks">Student VIP Textbooks</a> (formerly Textbook Exchange) for secondhand books.</li><li>Check out <a href="https://www.facebook.com/pages/Textbook-Exchange-The-University-Of-Newcastle/100620046653653?ref=ts&amp;fref=ts">Textbook Exchange - The University of Newcastle</a> on Facebook.</li></ul><strong>Please note:</strong> We encourage students to attend their first lecture/class before purchasing prescribed textbooks.'),
('41', '16', '', 'Traffic and parking rules apply at our campuses. Students, staff and visitors to the University park their vehicle on campus at their own risk. '),
('42', '16', '', 'The Ourimbah Campus offers free parking in designated spots around the campus. There are a range of parking signs used to highlight the traffic and parking rules for a particular area.'),
('43', '9', '', 'Click here to go to our study essentials page and find out about all the study tips and tricks for Newcastle University.'),
('44', '10', '', 'Click here to access our FAQ page, where we have answers to all of your concerns regarding commencement of study.');


