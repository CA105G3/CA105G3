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
-- create member OK
-----------------------------------------------
CREATE TABLE MEMBER(
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    memid       VARCHAR2(20 BYTE) NOT NULL ,
    pwd         VARCHAR2(20 BYTE) NOT NULL ,
    memname     VARCHAR2(20 BYTE) NOT NULL ,
    phone       VARCHAR2(20 BYTE) NOT NULL ,
    birth       DATE NOT NULL ,
    regdate     DATE ,
    staytime    TIMESTAMP(6) NOT NULL ,
    memstatus   VARCHAR2(6 BYTE) NOT NULL ,
    ident       VARCHAR2(12 BYTE) NOT NULL ,
    gender      VARCHAR2(3 BYTE) NOT NULL ,
    email       VARCHAR2(50 BYTE) NOT NULL ,
    locno       NUMBER(5, 0) NOT NULL ,
    addr        VARCHAR2(60 BYTE) NOT NULL ,
    bloodtype   VARCHAR2(2 BYTE) ,
    smoking     VARCHAR2(6 BYTE) ,
    allergy     VARCHAR2(600 BYTE) ,
    medhistory  VARCHAR2(600 BYTE) ,
    famhistory  VARCHAR2(600 BYTE) ,
    mempic      BLOB ,
    CONSTRAINT member_pk PRIMARY KEY (memno),
    CONSTRAINT memid_unique UNIQUE (memid),
    CONSTRAINT chk_memstatus CHECK (memstatus IN('正常','停用')),
    CONSTRAINT chk_ident CHECK (ident IN('一般會員','醫療人員','餐飲業者')),
    CONSTRAINT chk_gender CHECK (gender IN('男','女','無')),
    CONSTRAINT chk_bloodtype CHECK (bloodtype IN('A','B','AB','O')),
    CONSTRAINT chk_smoking CHECK (smoking IN('有','沒有'))
);
CREATE SEQUENCE member_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'David','David123456','David','09123456789',TO_DATE('1981-01-01','YYYY-MM-DD'),TO_DATE('2018-4-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-11-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','david001@gmail.com',22244,'中央大學中央路255號','AB','有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Mary','Mary123456','Mary','09213456789',TO_DATE('1982-02-02','YYYY-MM-DD'),TO_DATE('2018-6-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','mary001@gmail.com',22244,'中央大學中央路256號','O','沒有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Jim','Jim123457','Jim','09883456789',TO_DATE('1983-03-03','YYYY-MM-DD'),TO_DATE('2018-5-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','jim001@gmail.com',22244,'中央大學中央路257號','O','沒有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Harry','Harry123457','Harry','09833456789',TO_DATE('1984-04-04','YYYY-MM-DD'),TO_DATE('2018-4-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),'停用','一般會員','男','harry001@gmail.com',22244,'中央大學中央路258號','A','有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Jay','Jay123457','Jay','09343456789',TO_DATE('1985-05-05','YYYY-MM-DD'),TO_DATE('2018-8-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','Jay001@gmail.com',22244,'中央大學中央路259號','B','沒有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Kim','Kim123457','Kim','09423456789',TO_DATE('1986-06-06','YYYY-MM-DD'),TO_DATE('2018-9-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','Kim001@gmail.com',22244,'中央大學中央路260號','A','沒有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Adele','Adele123457','Adele','09733555555',TO_DATE('1987-07-07','YYYY-MM-DD'),TO_DATE('2018-9-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','Adele001@gmail.com',22244,'中央大學中央路261號','AB','有','此為文字串','此為文字串','此為文字串',NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Trista','Trista123457','Trista','0943334589',TO_DATE('1988-08-08','YYYY-MM-DD'),TO_DATE('2018-9-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','Trista@gmail.com',22244,'中央大學中央路262號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Alan','Alan123457','Alan','0943334659',TO_DATE('1988-08-09','YYYY-MM-DD'),TO_DATE('2018-9-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Alan@gmail.com',22244,'中央大學中央路263號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Blake','Blake123457','Blake','0943323469',TO_DATE('1988-08-10','YYYY-MM-DD'),TO_DATE('2018-9-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Blake@gmail.com',22244,'中央大學中央路264號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Venus','Venus123457','Venus','0943352859',TO_DATE('1988-08-11','YYYY-MM-DD'),TO_DATE('2018-9-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Venus@gmail.com',22244,'中央大學中央路265號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Yuri','Yuri123457','Yuri','0943754239',TO_DATE('1988-08-12','YYYY-MM-DD'),TO_DATE('2018-9-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Yuri@gmail.com',22244,'中央大學中央路266號','B','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Zoe','Zoe123457','Zoe','0948797889',TO_DATE('1988-08-13','YYYY-MM-DD'),TO_DATE('2018-9-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','Zoe@gmail.com',22244,'中央大學中央路267號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Chief_Duke','Duke123457','Duke','0943787589',TO_DATE('1988-08-14','YYYY-MM-DD'),TO_DATE('2018-9-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','Duke@gmail.com',22244,'中央大學中央路268號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Astor','Astor123457','Astor','0943975335',TO_DATE('1988-08-15','YYYY-MM-DD'),TO_DATE('2018-9-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Astor@gmail.com',22244,'中央大學中央路269號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Bob','Bob123457','Bob','0943367431',TO_DATE('1988-08-16','YYYY-MM-DD'),TO_DATE('2018-9-4 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-14 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Bob@gmail.com',22244,'中央大學中央路270號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Sylvia','Sylvia123457','Sylvia','0989743489',TO_DATE('1988-08-17','YYYY-MM-DD'),TO_DATE('2018-9-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Sylvia@gmail.com',22244,'中央大學中央路271號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Tess','Tess123457','Tess','0940675369',TO_DATE('1988-08-18','YYYY-MM-DD'),TO_DATE('2018-9-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Tess@gmail.com',22244,'中央大學中央路272號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Kobe','Kobe123457','Kobe','0943324362',TO_DATE('1988-08-19','YYYY-MM-DD'),TO_DATE('2018-9-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','Kobe@gmail.com',22244,'中央大學中央路273號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Doctor_Queen','Queen123457','Queen','0942343245',TO_DATE('1988-08-20','YYYY-MM-DD'),TO_DATE('2018-9-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','Queen@gmail.com',22244,'中央大學中央路274號','B','沒有',NULL,NULL,NULL,NULL);

-----------------------------------------------
-- create license OK
-----------------------------------------------
CREATE TABLE license(
    licno       VARCHAR2(5 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    licdata     BLOB ,
    licstatus   VARCHAR2(9 BYTE) NOT NULL ,
    licdesc     VARCHAR2(500 BYTE) NOT NULL ,
    licdue      DATE ,
    CONSTRAINT licence_pk PRIMARY KEY (licno),
    CONSTRAINT licence_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT chk_licstatus CHECK (licstatus IN('生效中','已失效','審核中'))
);
    
CREATE SEQUENCE license_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0001',NULL,'生效中','不明證照',TO_DATE('2028-12-31','YYYY-MM-DD'));
INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0017',NULL,'生效中','黑證照',TO_DATE('2020-01-22','YYYY-MM-DD'));
INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0018',NULL,'已失效','特級廚師證照',TO_DATE('2018-03-03','YYYY-MM-DD'));
INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0019',NULL,'生效中','多益證照',TO_DATE('2025-11-12','YYYY-MM-DD'));
INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0016',NULL,'生效中','獵人職照',TO_DATE('2023-08-09','YYYY-MM-DD'));
INSERT INTO license VALUES('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),'M0020',NULL,'已失效','霍格華茲畢業證書',TO_DATE('2016-07-16','YYYY-MM-DD'));
-----------------------------------------------
-- create administrator OK
-----------------------------------------------
CREATE TABLE administrator(
    adminno     VARCHAR2(5 BYTE) NOT NULL ,
    adminid     VARCHAR2(10 BYTE) NOT NULL ,
    adminpsw    VARCHAR2(10 BYTE) NOT NULL ,
    adminname   VARCHAR2(15 BYTE) NOT NULL ,
    PRIORITY    VARCHAR2(18 BYTE) NOT NULL ,
    status      VARCHAR2(9 BYTE) NOT NULL ,
    reg         DATE ,
    CONSTRAINT administrator_pk PRIMARY KEY (adminno),
    CONSTRAINT adminid_unique UNIQUE (adminid),
    CONSTRAINT chk_priority CHECK (PRIORITY IN('一般管理員','總理管理員')),
    CONSTRAINT chk_status CHECK (status IN('生效中','已失效'))
);

CREATE SEQUENCE administrator_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'Peter','123456','吳永志','總理管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'David','123456','吳冠宏','總理管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'Scarlett','123456','史嘉蕾','一般管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'Amin','123456','阿民','一般管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'Gakki','123456','結衣','一般管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'GuanGuan','123456','關關','一般管理員','生效中',TO_DATE('2018-12-01','YYYY-MM-DD'));


-----------------------------------------------
-- create activity OK
-----------------------------------------------
CREATE TABLE activity(
    actno       VARCHAR2(7 BYTE),
    memno       VARCHAR2(5 BYTE),
    actname     VARCHAR2(50 BYTE) NOT NULL,
    actloc      VARCHAR2(50 BYTE) NOT NULL,
    acttime     DATE NOT NULL,
    actstatus   VARCHAR2(9 BYTE) NOT NULL,
    actmax	NUMBER(5,0) NOT NULL,
    actlimit    NUMBER(5,0) NOT NULL, 
    timecheck   NUMBER(2,0) NOT NULL,
    actdesc     VARCHAR2(300 BYTE),
    actpic      BLOB,
    latitude    VARCHAR2(50 BYTE) NOT NULL,
    longtitude  VARCHAR2(50 BYTE) NOT NULL,
    CONSTRAINT activity_pk PRIMARY KEY (actno),
    CONSTRAINT activity_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT chk_actstatus CHECK (actstatus IN('募集中','已結束','已取消'))
);

CREATE SEQUENCE activity_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','太陽拳比賽','桃園市中壢區中正公園',TO_DATE('2018-12-31','YYYY-MM-DD'),'募集中',10,3,2,'誰是最強的太陽拳繼承者!一起來挑戰八!',NULL,24.960402,121.226430);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0008','捕獲寶可夢','桃園市中壢區精五行養身館',TO_DATE('2018-01-13','YYYY-MM-DD'),'已結束',50,20,1,'鳳王路奇亞現蹤，需組一團來攻陷，加入我吧!',NULL,24.959477,121.218103);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0012','外丹功推廣','桃園市中壢區沙皇風尚咖啡館',TO_DATE('2018-08-26','YYYY-MM-DD'),'已結束',150,50,3,'外丹功好，強身健體，還不受中共壓迫歐',NULL,24.957615,121.212902);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0007','看夜景','桃園市中壢區社會福利基金會',TO_DATE('2019-05-20','YYYY-MM-DD'),'募集中',10,5,5,'高雄發大財，錢進得來，出的去，韓總讓大家賺大錢',NULL,24.959594,121.206722);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0018','腳踏車競速','永安漁港',TO_DATE('2018-09-01','YYYY-MM-DD'),'募集中',100,45,2,'我是彭于晏，邀請大家陪我尬車競速',NULL,24.988651,121.014494);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0010','翻墮羅拳展示','桃園市中壢區SOGO',TO_DATE('2018-10-11','YYYY-MM-DD'),'募集中',30,5,1,'秘術拳法徵求繼承者，意者請洽我',NULL,24.962474,121.223562);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0019','象棋大賽','中壢區新勢公園',TO_DATE('2019-02-02','YYYY-MM-DD'),'募集中',60,10,1,'高處不勝寒，坐擁榕樹下20年，誰能贏我',NULL,24.951806,121.216693);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0013','慈善撲克大賽','佑民醫院',TO_DATE('2019-01-24','YYYY-MM-DD'),'募集中',500,100,10,'20塊港幣想贏到100萬，哈哈哈哈，好啊我借你',NULL,24.957371,121.203808);

-----------------------------------------------
-- create Joinact OK
-----------------------------------------------
CREATE TABLE joinact(
    actno   VARCHAR2(7 BYTE),
    memno   VARCHAR2(5 BYTE),
    joinstatus  NUMBER(1, 0) NOT NULL,
    CONSTRAINT joinact_pk PRIMARY KEY (actno,memno),
    CONSTRAINT joinact_fk1 FOREIGN KEY (actno) REFERENCES activity (actno),
    CONSTRAINT joinact_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno)
);
    
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0001','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0008',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0006','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0001','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0001','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0008','M0001',1);
-----------------------------------------------
-- create impression OK
-----------------------------------------------
CREATE TABLE impression(
    impno       VARCHAR2(5 BYTE),
    imptime     DATE NOT NULL,
    impname     VARCHAR2(30 BYTE),
    actno       VARCHAR2(7 BYTE),
    memno       VARCHAR2(5 BYTE),
    impcon      VARCHAR2(2000 BYTE) ,
    recvideo    BLOB ,
    recpic      BLOB ,
    impfield    VARCHAR2(12 BYTE) ,
    CONSTRAINT impression_pk PRIMARY KEY (impno),
    CONSTRAINT impression_fk1 FOREIGN KEY (actno,memno) REFERENCES joinact(actno,memno),
    CONSTRAINT chk_impfield CHECK (impfield IN('文字心得','影片','照片'))
);

CREATE SEQUENCE impression_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'比克魔王太強大','ACT0001','M0001','沒心得',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'抓到波克比','ACT0002','M0012','沒心得',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'前往真新鎮','ACT0002','M0010','今天花了我好幾顆金莓果才搞定班基拉斯，看來我的曲E還要再練練。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'我是破風手','ACT0005','M0017','隔壁老王實在太弱了，根本比不贏我中和鵬魚雁，下次練練再來吧!',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'健康你我他','ACT0003','M0019','外丹功重在練心，重中之重，凡人不會理解的。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'高雄賺大錢','ACT0004','M0008','今天與隔壁李太太看了愛河的夜景，讓我又燃起了年輕時候戀愛的感覺啊!',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'抖手救世界','ACT0003','M0002','外丹功總共有十二式，彈抖運動是其主流。彈抖動作配合節奏的呼吸，可使人體保持肌肉鬆弛，呼吸平順，身體的供氧量充足，經過約數十分鐘的彈抖動作之後，整個人便覺身輕氣爽。',NULL,NULL,'文字心得');

-----------------------------------------------
-- create reportact OK
-----------------------------------------------
CREATE TABLE reportact（
    repano      VARCHAR2(8 BYTE),
    actno       VARCHAR2(7 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    repastatus  VARCHAR2(9 BYTE) NOT NULL ,
    CONSTRAINT reportact_pk PRIMARY KEY (repano),
    CONSTRAINT reportact_fk1 FOREIGN KEY (actno) REFERENCES activity (actno),
    CONSTRAINT reportact_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT chk_repastatus CHECK (repastatus IN('未檢查','已檢查'))
）;
    
CREATE SEQUENCE reportact_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO reportact VALUES ('REPA'||lpad(to_char(reportact_seq.NEXTVAL), 4, '0'),'ACT0001','M0001','未檢查');

-----------------------------------------------
-- create trace OK
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
-- create memberchef OK
-----------------------------------------------
CREATE TABLE memberchef(
    chefno          VARCHAR2(8 BYTE) NOT NULL ,
    memno           VARCHAR2(5 BYTE) NOT NULL ,
    chefname        VARCHAR2(30 BYTE) NOT NULL ,
    chefstorename   VARCHAR2(30 BYTE) NOT NULL ,
    chefpic         BLOB ,
    chefdescrip     VARCHAR2(300 BYTE) ,
    chefstatus      VARCHAR2(9 BYTE) NOT NULL ,
    chefphone       NUMBER ,
    chefaddr        VARCHAR2(60 BYTE) ,
    chefrep         VARCHAR2(15 BYTE) ,
    CONSTRAINT memberchef_pk PRIMARY KEY (chefno),
    CONSTRAINT memberchef_fk FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT chk_chefstatus CHECK (chefstatus IN('停用','啓用','審核中')));
    
CREATE SEQUENCE memberchef_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0011','孫小美','愛的廚房',NULL,'人家最擅長的就是愛的料理','啓用','03987456','中央大學內','阿土伯');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0012','超級鯉魚王','生猛海鮮',NULL,'全宇宙最生猛的海鮮','啓用',756629600,'西太平洋馬里亞那海溝','波賽頓');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0013','小噹家','洋泉大酒家',NULL,'廣東省廣州市最具知名的第一餐館，中壢分館是邁向征服全世界的海外首間分館','啓用',11469883,'四川省成都菊上樓','及第師傅');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0014','老皮','真心鎮',NULL,'今年10歲，卻擁有21年料理經歷的男人','啓用',55469883,'真心鎮','小小智');

-----------------------------------------------
-- create menu OK
-----------------------------------------------
CREATE TABLE menu(
    menuno      VARCHAR2(13 BYTE) NOT NULL ,
    chefno      VARCHAR2(8 BYTE) NOT NULL ,
    unitprice   NUMBER ,
    maincourse  VARCHAR2(24 BYTE) NOT NULL ,
    menupic     BLOB ,
    deliverable VARCHAR2(12 BYTE) ,
    menuintro   VARCHAR2(2000 BYTE),
    CONSTRAINT menu_pk PRIMARY KEY (menuno),
    CONSTRAINT menu_fk FOREIGN KEY (chefno) REFERENCES memberchef (chefno),
    CONSTRAINT chk_deliverable CHECK (deliverable IN('可送餐','不可送餐'))
);
    
CREATE SEQUENCE menu_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','60','滿漢全席',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','600','滿漢全席',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','20','燒肉飯桶',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','30','宅男咖哩',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','50','珍珠爆乳茶',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','60','飛天紅豆湯',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','99','火焰炸雞',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','138','阿嬤漢堡',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','199','尼古丁比薩',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','66','昇天河豚鍋',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','45','氫酸鉀咖啡',NULL,'可送餐',NULL);
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','87','超級三寶飯',NULL,'可送餐',NULL);

-----------------------------------------------
-- create menulist OK
-----------------------------------------------
CREATE TABLE menulist(
    menulistno      VARCHAR2(13 BYTE) NOT NULL ,
    menuno          VARCHAR2(13 BYTE) NOT NULL ,
    menudate        DATE ,
    menutimeslot    VARCHAR2(3 BYTE) NOT NULL ,
    CONSTRAINT menulist_pk PRIMARY KEY (menulistno),
    CONSTRAINT menulist_fk FOREIGN KEY (menuno) REFERENCES menu (menuno),
    CONSTRAINT chk_menutimeslot CHECK (menutimeslot IN('早','午','晚'))
);

CREATE SEQUENCE menulist_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190220','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190225','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190105','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190105','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190105','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190109','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190122','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190122','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190106','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190106','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190107','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190108','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190109','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190110','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190111','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190112','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190113','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190114','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190114','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190114','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190119','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190119','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190119','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190130','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190113','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190131','YYYYMMDD'),'早');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190117','YYYYMMDD'),'午');

-----------------------------------------------
-- create foodorder OK
-----------------------------------------------
CREATE TABLE foodorder(
    orderno     VARCHAR2(13 BYTE) NOT NULL ,
    memno       VARCHAR2(5 BYTE) NOT NULL ,
    deliveraddr VARCHAR2(60 BYTE) ,
    chefno      VARCHAR2(8 BYTE) NOT NULL ,
    orderstatus VARCHAR2(9 BYTE) NOT NULL ,
    ordtime     TIMESTAMP ,
    CONSTRAINT foodorder_pk PRIMARY KEY (orderno),
    CONSTRAINT foodorder_fk1 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT foodorder_fk2 FOREIGN KEY (chefno) REFERENCES memberchef (chefno),
    CONSTRAINT chk_orderstatus CHECK (orderstatus IN('不接受','接受','審核中'))
）;

CREATE SEQUENCE foodorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','中央大學','CHEF0001','接受',current_timestamp);

-----------------------------------------------
-- create orderdetail OK
-----------------------------------------------
CREATE TABLE orderdetail(
    odno        VARCHAR2(13 BYTE),
    orderno     VARCHAR2(13 BYTE),
    menulistno  VARCHAR2(13 BYTE) NOT NULL ,
    amount      NUMBER NOT NULL ,
    unitprice   NUMBER NOT NULL ,
    odstatus	VARCHAR2(6 BYTE),
    CONSTRAINT orderdetail_pk PRIMARY KEY (odno),
    CONSTRAINT orderdetail_fk1 FOREIGN KEY (orderno) REFERENCES foodorder (orderno),
    CONSTRAINT orderdetail_fk2 FOREIGN KEY (menulistno) REFERENCES menulist (menulistno),
    CONSTRAINT chk_odstatus CHECK (odstatus IN('取消',NULL))
);

CREATE SEQUENCE orderdetail_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO orderdetail VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.CURRVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.CURRVAL), 4, '0'),'99','60',NULL);

-----------------------------------------------
-- create doctor OK
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
    CONSTRAINT chk_isonline CHECK (isonline IN('線上','離線')),
    CONSTRAINT chk_doctorstatus CHECK (status IN('生效中','失效','審核中'))
);

CREATE SEQUENCE doctor_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------
--  醫療人員1
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0015',

'中華民國外科醫師、無黨籍政治人物，現任臺北市市長。
國立臺灣大學醫學院臨床醫學研究所博士畢業，曾任臺大醫院急診部醫師、臺大醫院創傷醫學部主任、臺大醫學院教授，
專長為外科重症醫學、器官移植 、人工器官等，是臺灣第一個急診與重症加護專職醫生，
為臺灣器官標準移植程序的建立者，也是首位將葉克膜（ECMO）技術引進臺灣的醫師。
2018年任命(學姊)黃瀞瑩為臺北市政府媒體事務組組員
','離線','失效','外科','4',NULL);
--------------------------------------------------------
--  醫療人員2
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0016',

'本名間黑男，從小父親因婚外情而私奔及離棄他及母親，因此和母親一起生活。
某日與母親出遊，因工程商的人為疏失，他誤觸未爆彈引發爆炸，母親送醫後不治，他也一度瀕死，
但終於被擁有高明醫術的本間丈太郎醫師救活。
痛苦的復健過程中，使他活下去的動力只有兩個：成為和本間醫師一樣的一流外科醫師，以及報復害死母親的工程商關係人。
若干年後，間黑男果真習得世界頂尖的外科技術，不過由於對醫學的理念不見容於醫學界，醫師執照被吊銷，
但他仍憑其高超的醫術自己開診所，並向病患收取鉅額手術費。          
人們稱這位無照行醫的外科天才為：黑傑克。','線上','審核中','外科','999999999',NULL);

--------------------------------------------------------
--  醫療人員3
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0017','國泰綜合醫院皮膚科暨醫學美容中心主治醫師
內湖國泰綜合醫院皮膚科主治醫師
汐止國泰綜合醫院皮膚科主治醫師
新竹國泰綜合醫院皮膚科主治醫師
中華民國皮膚科專科醫師
台灣皮膚科醫學會會員','線上','生效中','皮膚科','200',NULL);

--------------------------------------------------------
--  醫療人員4
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0018','中國醫藥大學醫學系畢業
台灣大學醫學系臨床醫學研究所碩士
台灣耳鼻喉科專科醫師
台灣顏面整形重建外科專科醫師
台大醫院耳鼻喉部進修
韓國Asan醫學中心鼻整形手術課程進修
國泰醫學中心耳鼻喉科住院醫師
國泰醫學中心耳鼻喉科總醫師
國泰綜合醫院內湖分院耳鼻喉科主治醫師
國泰綜合醫院新竹分院耳鼻喉科主治醫師
汐止國泰醫院耳鼻喉頭頸外科主治醫師
汐止國泰醫院耳鼻喉頭頸外科主任
台灣美容醫學教育訓練聯合委員會委員
衛生福利部美容醫學教育訓練諮議會委員','離線','生效中','耳鼻喉科','7777',NULL);

--------------------------------------------------------
--  醫療人員5
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0019',

'台大醫學系畢業

前台大醫院醫師

前衛生署醫策會委員

美國醫師考試FMGEMS及格

前秀傳醫院皮膚科專任醫師

台大糖尿病衛教小組訓練','線上','生效中','家醫科','9487',NULL);



--------------------------------------------------------
--  醫療人員6
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0020','【我們心理諮商所】合作心理師
【龍華科技大學】專任諮商心理師
【新北市泰山高中】專任輔導教師
【新北市泰山區】國小專任輔導教師
​【亞東醫院精神科自殺防治中心】輔導員
【新北市厚德國小】高風險家庭團體帶領者
【法務部矯正署台北監獄】性侵加害人團體觀察員','線上','生效中','心理諮商','6666',NULL);




-----------------------------------------------
-- create doctoravailable OK
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

INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0001',TO_DATE('20181201','YYYYMMDD'),'110011100101000110000010111111001001111101111110110010011010100011110001001101011000101010110');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0003',TO_DATE('20190101','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0003',TO_DATE('20190201','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0004',TO_DATE('20190101','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0004',TO_DATE('20190201','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0005',TO_DATE('20190101','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0005',TO_DATE('20190201','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0006',TO_DATE('20190101','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0006',TO_DATE('20190201','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');

-----------------------------------------------
-- create medicalorder OK
-----------------------------------------------
CREATE TABLE medicalorder(
    mono            VARCHAR2(13 BYTE) NOT NULL ,
    memno           VARCHAR2(5 BYTE) NOT NULL ,
    drno            VARCHAR2(5 BYTE) NOT NULL ,
    mostatus        VARCHAR2(12 BYTE) NOT NULL ,
    mocost          NUMBER ,
    motime          DATE ,
    mohour			NUMBER,
    mointro         CLOB NOT NULL ,
    mocancelreason  VARCHAR2(150 BYTE),    
    movideo         BLOB ,
    motext          VARCHAR2(2000 BYTE) ,
    CONSTRAINT medicalorder_pk PRIMARY KEY (mono),
    CONSTRAINT medicalorder_fk1 FOREIGN KEY (memno) REFERENCES MEMBER (memno),
    CONSTRAINT medicalorder_fk2 FOREIGN KEY (drno) REFERENCES doctor (drno),
    CONSTRAINT chk_mostatus CHECK (mostatus IN('等待審核','等待問診','問診完成','取消問診')),
    CONSTRAINT chk_mohour CHECK (mohour IN('9','13','17'))
);

CREATE SEQUENCE medicalorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0001','等待問診',870,TO_DATE('20181223','YYYYMMDD'),'13','生理痛不舒服',NULL,NULL,NULL);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','問診完成',9487,TO_DATE('20190101','YYYYMMDD'),'13','心臟疼痛不止',NULL,NULL,'建議到大型醫院檢查');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','等待問診',9487,TO_DATE('20190202','YYYYMMDD'),'17','晚上睡不著，白天一直睡',NULL,NULL,NULL);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0003','問診完成',9999,TO_DATE('20181203','YYYYMMDD'),'9','蚊子叮咬',NULL,NULL,'開藥藥給你擦');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0003','D0003','等待問診',9999,TO_DATE('20190124','YYYYMMDD'),'9','頭皮發癢',NULL,NULL,NULL);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0004','D0004','問診完成',7777,TO_DATE('20181105','YYYYMMDD'),'9','白天不會咳，躺下睡覺一直咳',NULL,NULL,'藥劑三餐飯後+睡前吃');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0005','D0005','取消問診',8888,TO_DATE('20181006','YYYYMMDD'),'13','眼睛痛',NULL,NULL,NULL);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0006','D0004','等待問診',7777,TO_DATE('20190124','YYYYMMDD'),'9','耳朵會流出臭臭的不明液體，耳屎挖出來有血色',NULL,NULL,NULL);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0007','D0006','等待審核',6666,TO_DATE('20190210','YYYYMMDD'),'17','心情低落，做什麼事都提不起勁，想死',NULL,NULL,NULL);
-----------------------------------------------
-- create favdr OK
-----------------------------------------------
CREATE TABLE favdr(
    memno   VARCHAR2(5 BYTE) NOT NULL ,
    drno    VARCHAR2(5 BYTE) NOT NULL ,
    CONSTRAINT favdr_pk PRIMARY KEY (memno,drno),
    CONSTRAINT favdr_fk1 FOREIGN KEY (drno) REFERENCES doctor (drno),
    CONSTRAINT favdr_fk2 FOREIGN KEY (memno) REFERENCES MEMBER (memno)
);

INSERT INTO favdr VALUES ('M0002','D0001');
INSERT INTO favdr VALUES ('M0007','D0006');
INSERT INTO favdr VALUES ('M0007','D0002');
INSERT INTO favdr VALUES ('M0001','D0003');
INSERT INTO favdr VALUES ('M0003','D0005');
INSERT INTO favdr VALUES ('M0003','D0004');
-----------------------------------------------
-- create reportdr OK
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
    CONSTRAINT chk_rdrstate CHECK (rdrstate IN('未處理','審核未通過','審核已通過'))
);
    
CREATE SEQUENCE reportdr_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;    
    
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0002','D0001','太醜',current_timestamp,'未處理');
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0004','D0001','病歷表亂寫',current_timestamp,'未處理');
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0005','D0001','看病很隨便',current_timestamp,'未處理');

-----------------------------------------------
-- create ptttool OK
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

COMMIT;

