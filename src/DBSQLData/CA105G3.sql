DROP TABLE ppttool;
DROP TABLE reportdr;
DROP TABLE favdr;
DROP TABLE medicalorder;
DROP TABLE doctoravailable;
DROP TABLE doctor;
DROP TABLE orderdetail;
DROP TABLE foodorder;
DROP TABLE menulist;
DROP TABLE menu;
DROP TABLE memberchef;
DROP TABLE TRACE;
DROP TABLE reportact;
DROP TABLE impression;
DROP TABLE joinact;
DROP TABLE activity;
DROP TABLE administrator;
DROP TABLE license;
DROP TABLE MEMBER;

DROP SEQUENCE ppttool_seq;
DROP SEQUENCE reportdr_seq;
DROP SEQUENCE medicalorder_seq;
DROP SEQUENCE doctoravailable_seq;
DROP SEQUENCE doctor_seq;
DROP SEQUENCE orderdetail_seq;
DROP SEQUENCE foodorder_seq;
DROP SEQUENCE menulist_seq;
DROP SEQUENCE menu_seq;
DROP SEQUENCE memberchef_seq;
DROP SEQUENCE reportact_seq;
DROP SEQUENCE impression_seq;
DROP SEQUENCE activity_seq;
DROP SEQUENCE administrator_seq;
DROP SEQUENCE license_seq;
DROP SEQUENCE member_seq;

-----------------------------------------------
-- create member
-----------------------------------------------
CREATE TABLE MEMBER 
(
    memNo       VARCHAR2(5 BYTE) NOT NULL ,
    memId       VARCHAR2(20 BYTE) NOT NULL ,
    pwd         VARCHAR2(20 BYTE) NOT NULL ,
    memName     VARCHAR2(20 BYTE) NOT NULL ,
    phone       VARCHAR2(20 BYTE) NOT NULL ,
    birth       DATE NOT NULL ,
    regDate     DATE ,
    stayTime    TIMESTAMP(6) NOT NULL ,
    memStatus   VARCHAR2(6 BYTE) NOT NULL ,
    ident       VARCHAR2(12 BYTE) NOT NULL ,
    gender      VARCHAR2(3 BYTE) NOT NULL ,
    email       VARCHAR2(50 BYTE) NOT NULL ,
    locno       NUMBER(5, 0) NOT NULL ,
    addr        VARCHAR2(60 BYTE) NOT NULL ,
    bloodType   VARCHAR2(2 BYTE) ,
    smoking     VARCHAR2(6 BYTE) ,
    allergy     VARCHAR2(600 BYTE) ,
    medHistory  VARCHAR2(600 BYTE) ,
    famHistory  VARCHAR2(600 BYTE) ,
    CONSTRAINT member_pk PRIMARY KEY (memNo),
    CONSTRAINT MEMID_unique UNIQUE (memId),
    CONSTRAINT CHK_MEMSTATUS CHECK (memStatus in('正常','停用')),
    CONSTRAINT CHK_IDENT CHECK (ident in('一般會員','醫療人員','餐飲業者')),
    CONSTRAINT CHK_GENDER CHECK (gender in('男','女','無')),
    CONSTRAINT CHK_BLOODTYPE CHECK (bloodType in('A','B','AB','O')),
    CONSTRAINT CHK_SMOKING CHECK (smoking in('有','沒有'))
);
CREATE SEQUENCE member_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'David','David123456','David','09123456789',TO_DATE('1981-01-01','YYYY-MM-DD'),TO_DATE('2018-4-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-11-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','david001@gmail.com',22244,'中央大學中央路255號','AB','有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Mary','Mary123456','Mary','09213456789',TO_DATE('1982-02-02','YYYY-MM-DD'),TO_DATE('2018-6-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','mary001@gmail.com',22244,'中央大學中央路256號','O','沒有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Jim','Jim123457','Jim','09883456789',TO_DATE('1983-03-03','YYYY-MM-DD'),TO_DATE('2018-5-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','jim001@gmail.com',22244,'中央大學中央路257號','O','沒有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Harry','Harry123457','Harry','09833456789',TO_DATE('1984-04-04','YYYY-MM-DD'),TO_DATE('2018-4-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),'停用','一般會員','男','harry001@gmail.com',22244,'中央大學中央路258號','A','有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Jay','Jay123457','Jay','09343456789',TO_DATE('1985-05-05','YYYY-MM-DD'),TO_DATE('2018-8-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','Jay001@gmail.com',22244,'中央大學中央路259號','B','沒有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Kim','Kim123457','Kim','09423456789',TO_DATE('1986-06-06','YYYY-MM-DD'),TO_DATE('2018-9-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','Kim001@gmail.com',22244,'中央大學中央路260號','A','沒有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Adele','Adele123457','Adele','09733555555',TO_DATE('1987-07-07','YYYY-MM-DD'),TO_DATE('2018-9-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','Adele001@gmail.com',22244,'中央大學中央路261號','AB','有','此為文字串','此為文字串','此為文字串');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Trista','Trista123457','Trista','0943334589',TO_DATE('1988-08-08','YYYY-MM-DD'),TO_DATE('2018-9-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','Trista@gmail.com',22244,'中央大學中央路262號','O','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Alan','Alan123457','Alan','0943334659',TO_DATE('1988-08-09','YYYY-MM-DD'),TO_DATE('2018-9-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Alan@gmail.com',22244,'中央大學中央路263號','AB','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Blake','Blake123457','Blake','0943323469',TO_DATE('1988-08-10','YYYY-MM-DD'),TO_DATE('2018-9-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Blake@gmail.com',22244,'中央大學中央路264號','A','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Venus','Venus123457','Venus','0943352859',TO_DATE('1988-08-11','YYYY-MM-DD'),TO_DATE('2018-9-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Venus@gmail.com',22244,'中央大學中央路265號','O','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Yuri','Yuri123457','Yuri','0943754239',TO_DATE('1988-08-12','YYYY-MM-DD'),TO_DATE('2018-9-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Yuri@gmail.com',22244,'中央大學中央路266號','B','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Zoe','Zoe123457','Zoe','0948797889',TO_DATE('1988-08-13','YYYY-MM-DD'),TO_DATE('2018-9-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Zoe@gmail.com',22244,'中央大學中央路267號','A','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Duke','Duke123457','Duke','0943787589',TO_DATE('1988-08-14','YYYY-MM-DD'),TO_DATE('2018-9-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Duke@gmail.com',22244,'中央大學中央路268號','AB','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Astor','Astor123457','Astor','0943975335',TO_DATE('1988-08-15','YYYY-MM-DD'),TO_DATE('2018-9-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Astor@gmail.com',22244,'中央大學中央路269號','O','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Bob','Bob123457','Bob','0943367431',TO_DATE('1988-08-16','YYYY-MM-DD'),TO_DATE('2018-9-4 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-14 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Bob@gmail.com',22244,'中央大學中央路270號','A','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Sylvia','Sylvia123457','Sylvia','0989743489',TO_DATE('1988-08-17','YYYY-MM-DD'),TO_DATE('2018-9-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Sylvia@gmail.com',22244,'中央大學中央路271號','O','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Tess','Tess123457','Tess','0940675369',TO_DATE('1988-08-18','YYYY-MM-DD'),TO_DATE('2018-9-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Tess@gmail.com',22244,'中央大學中央路272號','AB','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Kobe','Kobe123457','Kobe','0943324362',TO_DATE('1988-08-19','YYYY-MM-DD'),TO_DATE('2018-9-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Kobe@gmail.com',22244,'中央大學中央路273號','A','沒有',null,null,null);
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Queen','Queen123457','Queen','0942343245',TO_DATE('1988-08-20','YYYY-MM-DD'),TO_DATE('2018-9-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Queen@gmail.com',22244,'中央大學中央路274號','B','沒有',null,null,null);

-----------------------------------------------
-- create license
-----------------------------------------------
CREATE TABLE license(
    licNo       VARCHAR2(5 BYTE) NOT NULL ,
    memNo       VARCHAR2(5 BYTE) NOT NULL ,
    licData     BLOB ,
    licStatus   VARCHAR2(9 BYTE) NOT NULL ,
    licDesc     VARCHAR2(500 BYTE) NOT NULL ,
    licDue      DATE  ,
    CONSTRAINT licence_pk PRIMARY KEY (licNo),
    CONSTRAINT licence_fk FOREIGN KEY (memNo) REFERENCES MEMBER (memNo),
    CONSTRAINT CHK_licstatus CHECK (licStatus in('生效中','已失效'))
);
    
CREATE SEQUENCE license_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0001',NULL,'生效中','不明證照',TO_DATE('2028-12-31','YYYY-MM-DD'));

-----------------------------------------------
-- create administrator
-----------------------------------------------
CREATE TABLE administrator
(
    adminNo     VARCHAR2(5 BYTE) NOT NULL ,
    adminID     VARCHAR2(10 BYTE) NOT NULL ,
    adminPSW     VARCHAR2(10 BYTE) NOT NULL ,
    PRIORITY    VARCHAR2(18 BYTE) NOT NULL ,
    status      VARCHAR2(9 BYTE) NOT NULL ,
    reg         DATE ,
    CONSTRAINT administrator_pk PRIMARY KEY (adminno),
    CONSTRAINT adminID_unique UNIQUE (adminID),
    CONSTRAINT CHK_PRIORITY CHECK (PRIORITY in('一般管理員','可新增管理員')),
    CONSTRAINT CHK_status CHECK (status in('生效中','已失效'))
);

CREATE SEQUENCE administrator_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'Jack','123456','一般管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));

-----------------------------------------------
-- create activity
-----------------------------------------------
CREATE TABLE activity
(
    actno       VARCHAR2(7 BYTE),
    memno       VARCHAR2(5 BYTE),
    actname     VARCHAR2(20 BYTE) NOT NULL,
    actloc      VARCHAR2(20 BYTE) NOT NULL,
    acttime     DATE NOT NULL,
    actstatus   VARCHAR2(9 BYTE) NOT NULL,
    actlimit    NUMBER(5,0) NOT NULL, 
    timecheck   NUMBER(2,0) NOT NULL, 
    CONSTRAINT activity_pk PRIMARY KEY (actno),
    CONSTRAINT activity_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT CHK_actstatus CHECK (actstatus in('舉辦中','已結束','已取消'))
);

CREATE SEQUENCE activity_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO activity VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','太陽拳比賽','那美克星',TO_DATE('2018-12-31','YYYY-MM-DD'),'舉辦中','10','3');

-----------------------------------------------
-- create Joinact
-----------------------------------------------
CREATE TABLE joinact(
    actno   VARCHAR2(7 BYTE),
    memno   VARCHAR2(5 BYTE),
    CONSTRAINT joinact_pk PRIMARY KEY (actno,memno),
    CONSTRAINT joinact_fk1 FOREIGN KEY (actno) REFERENCES activity (actno),
    CONSTRAINT joinact_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno)
);
    
INSERT INTO joinact VALUES('ACT0001','M0001');

-----------------------------------------------
-- create impression
-----------------------------------------------
CREATE TABLE impression
(
    impno       VARCHAR2(13 BYTE),
    actno       VARCHAR2(7 BYTE),
    memno       VARCHAR2(5 BYTE),
    impcon      VARCHAR2(2000 BYTE) ,
    recvideo    BLOB ,
    recpic      BLOB ,
    impfield    VARCHAR2(12 BYTE) ,
    CONSTRAINT impression_pk PRIMARY KEY (impno),
    CONSTRAINT IMPRESSION_FK1 FOREIGN KEY (actno,memno) REFERENCES JOINACT(actno,memno),
    CONSTRAINT CHK_impfield CHECK (impfield in('文字心得','影片','照片'))
);

CREATE SEQUENCE impression_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO impression VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),'ACT0001','M0001','沒心得',NULL,NULL,'文字心得');

-----------------------------------------------
-- create reportact
-----------------------------------------------
CREATE TABLE reportact（
    repano      VARCHAR2(8 BYTE) NOT NULL ,
    actno       VARCHAR2(7 BYTE) NOT NULL , 
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    repastatus  VARCHAR2(9 BYTE) NOT NULL ,
    CONSTRAINT reportact_pk PRIMARY KEY (repano),
    CONSTRAINT reportact_fk1 FOREIGN KEY (actno) REFERENCES activity (actno),
    CONSTRAINT reportact_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT CHK_repastatus CHECK (repastatus in('未檢查','已檢查'))
）;
    
CREATE SEQUENCE reportact_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO reportact VALUES ('REPA'||lpad(to_char(reportact_seq.NEXTVAL), 4, '0'),'ACT0001','M0001','未檢查');

-----------------------------------------------
-- create trace
-----------------------------------------------
CREATE TABLE TRACE(
    memno   VARCHAR2(5 BYTE) NOT NULL ,
    actno   VARCHAR2(7 BYTE) NOT NULL ,
    CONSTRAINT trace_pk PRIMARY KEY (memno,actno),
    CONSTRAINT trace_fk1 FOREIGN KEY (actno) REFERENCES activity (actno),
    CONSTRAINT trace_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno)
);

INSERT INTO TRACE VALUES ('M0001','ACT0001');

-----------------------------------------------
-- create memberchef
-----------------------------------------------
CREATE TABLE memberchef(
    chefno      VARCHAR2(8 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    chefpic     BLOB ,
    chefdescrip VARCHAR2(120 BYTE) ,
    chefstatus  VARCHAR2(9 BYTE) NOT NULL ,
    chefphone   NUMBER ,
    chefaddr    VARCHAR2(60 BYTE) ,
    chefrep     VARCHAR2(15 BYTE) ,
    CONSTRAINT memberchef_pk PRIMARY KEY (chefno),
    CONSTRAINT memberchef_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT CHK_chefstatus CHECK (chefstatus in('停用','啓用','審核中')));
    
CREATE SEQUENCE memberchef_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0001',NULL,'自我介紹','啓用','03987456','中央大學內','三普');

-----------------------------------------------
-- create menu
-----------------------------------------------
CREATE TABLE menu(
    menuno      VARCHAR2(13 BYTE) NOT NULL ,
    chefno      VARCHAR2(8 BYTE) NOT NULL ,
    unitprice   NUMBER ,
    maincourse  VARCHAR2(24 BYTE) NOT NULL ,
    menupic     BLOB ,
    deliverable VARCHAR2(12 BYTE) ,
    CONSTRAINT menu_pk PRIMARY KEY (menuno),
    CONSTRAINT menu_fk FOREIGN KEY (chefno) REFERENCES memberchef (chefno),
    CONSTRAINT CHK_deliverable CHECK (deliverable in('可送餐','不可送餐'))
);
    
CREATE SEQUENCE menu_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','60','滿漢全席',NULL,'可送餐');

-----------------------------------------------
-- create menudetail
-----------------------------------------------
CREATE TABLE menulist(
    menulistno      VARCHAR2(13 BYTE) NOT NULL ,
    menuno          VARCHAR2(13 BYTE) NOT NULL ,
    menudate        DATE ,
    menutimeslot    VARCHAR2(3 BYTE) NOT NULL ,
    CONSTRAINT menulist_pk PRIMARY KEY (menulistno),
    CONSTRAINT menulist_fk FOREIGN KEY (menuno) REFERENCES menu (menuno),
    CONSTRAINT CHK_menutimeslot CHECK (menutimeslot in('早','午',' 晚'))
);

CREATE SEQUENCE menulist_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20181225','YYYYMMDD'),'早');

-----------------------------------------------
-- create foodorder
-----------------------------------------------
CREATE TABLE foodorder(
    orderno     VARCHAR2(13 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    deliveraddr VARCHAR2(60 BYTE) ,
    chefno      VARCHAR2(8 BYTE) NOT NULL ,
    orderstatus VARCHAR2(9 BYTE) NOT NULL ,
    ordtime     DATE NOT NULL,
    CONSTRAINT foodorder_pk PRIMARY KEY (orderno),
    CONSTRAINT foodorder_fk1 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT foodorder_fk2 FOREIGN KEY (chefno) REFERENCES memberchef (chefno),
    CONSTRAINT CHK_orderstatus CHECK (orderstatus in('不接受','接受','審核中','已取消')));

CREATE SEQUENCE foodorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','中央大學','CHEF0001','接受',to_date('2019-02-02','yyyy-MM-dd'));

-----------------------------------------------
-- create orderdetail
-----------------------------------------------
CREATE TABLE orderdetail(
    odno        VARCHAR2(13 BYTE),
    orderno     VARCHAR2(13 BYTE),
    menulistno  VARCHAR2(13 BYTE) NOT NULL ,
    amount      NUMBER NOT NULL ,
    unitprice   NUMBER NOT NULL,
    CONSTRAINT orderdetail_pk PRIMARY KEY (odno),
    CONSTRAINT orderdetail_fk1 FOREIGN KEY (orderno) REFERENCES foodorder (orderno),
    CONSTRAINT orderdetail_fk2 FOREIGN KEY (menulistno) REFERENCES menulist (menulistno)
);

CREATE SEQUENCE orderdetail_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO orderdetail VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.CURRVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.CURRVAL), 4, '0'),'1','60');

-----------------------------------------------
-- create doctor
-----------------------------------------------
CREATE TABLE doctor(
    drno        VARCHAR2(5 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    RESUME      VARCHAR2(1500 BYTE) NOT NULL ,
    isonline    VARCHAR2(6 BYTE) NOT NULL ,
    status      VARCHAR2(9 BYTE) NOT NULL ,
    major       VARCHAR2(20 BYTE) NOT NULL ,
    fee         NUMBER ,
    photo       BLOB ,
    CONSTRAINT doctor_pk PRIMARY KEY (drno),
    CONSTRAINT doctor_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT CHK_isonline CHECK (isonline in('線上','離線')),
    CONSTRAINT CHK_doctorstatus CHECK (status in('生效中','失效','審核中'))
);

CREATE SEQUENCE doctor_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0002','專治性無能和投錯胎','線上','生效中','外科','9487',NULL);

-----------------------------------------------
-- create doctoravailable
-----------------------------------------------
CREATE TABLE doctoravailable(
    dravano VARCHAR2(13 BYTE) NOT NULL ,
    drno    VARCHAR2(5 BYTE) NOT NULL ,
    draym   DATE ,
    drava   VARCHAR2(93 BYTE) NOT NULL ,
    CONSTRAINT doctoravailable_pk PRIMARY KEY (dravano),
    CONSTRAINT doctoravailable_fk FOREIGN KEY (drno) REFERENCES doctor (drno)
);

CREATE SEQUENCE doctoravailable_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0001',TO_DATE('20181201','YYYYMMDD'),'1100110');

-----------------------------------------------
-- create medicalorder
-----------------------------------------------
CREATE TABLE medicalorder(
    mono        VARCHAR2(13 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    drno        VARCHAR2(5 BYTE) NOT NULL ,
    mostatus    VARCHAR2(12 BYTE) NOT NULL ,
    mocost      NUMBER ,
    motime      DATE ,
    mointro     CLOB NOT NULL ,
    movideo     BLOB ,
    motext      VARCHAR2(2000 BYTE) ,
    CONSTRAINT medicalorder_pk PRIMARY KEY (mono),
    CONSTRAINT medicalorder_fk1 FOREIGN KEY (memno) REFERENCES member (memno),
    CONSTRAINT medicalorder_fk2 FOREIGN KEY (drno) REFERENCES doctor (drno),
    CONSTRAINT CHK_mostatus CHECK (mostatus in('等待審核','等待問診','問診完成','取消問診'))
);

CREATE SEQUENCE medicalorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0001','等待問診','870',to_date('20181223','YYYYMMDD'),'生理痛不舒服',null,null);

-----------------------------------------------
-- create favdr
-----------------------------------------------
CREATE TABLE favdr(
    memno   VARCHAR2(5 BYTE) NOT NULL ,
    drno    VARCHAR2(5 BYTE) NOT NULL ,
    CONSTRAINT favdr_pk PRIMARY KEY (memno,drno),
    CONSTRAINT favdr_fk1 FOREIGN KEY (drno) REFERENCES doctor (drno),
    CONSTRAINT favdr_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno)
);

INSERT INTO favdr VALUES ('M0002','D0001');

-----------------------------------------------
-- create reportdr
-----------------------------------------------
CREATE TABLE reportdr(
    rdrno       VARCHAR2(7 BYTE) NOT NULL , 
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    drno        VARCHAR2(5 BYTE) NOT NULL ,
    rdrreason   VARCHAR2(50 BYTE) NOT NULL ,
    rdrtime     TIMESTAMP NOT NULL ,
    rdrstate    VARCHAR2(15 BYTE) NOT NULL ,
    CONSTRAINT reportdr_pk PRIMARY KEY (rdrno),
    CONSTRAINT reportdr_fk1 FOREIGN KEY (drno) REFERENCES doctor (drno),
    CONSTRAINT reportdr_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT CHK_rdrstate CHECK (rdrstate in('未處理','審核未通過','審核已通過'))
);
    
CREATE SEQUENCE reportdr_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;    
    
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0002','D0001','太醜',current_timestamp,'未處理');

-----------------------------------------------
-- create ptttool
-----------------------------------------------
CREATE TABLE ppttool(
    pptno   VARCHAR2(5 BYTE) NOT NULL , 
    drno    VARCHAR2(5 BYTE) NOT NULL , 
    ppt     BLOB ,
    CONSTRAINT ppttool_pk PRIMARY KEY (pptno),
    CONSTRAINT ppttool_fk FOREIGN KEY (drno) REFERENCES doctor (drno)
);

CREATE SEQUENCE ppttool_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE; 

INSERT INTO ppttool VALUES ('P'||lpad(to_char(ppttool_seq.NEXTVAL), 4, '0'),'D0001',NULL);

commit;

