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

INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'David','123456','大衛海鮮','0919740601',TO_DATE('1981-01-01','YYYY-MM-DD'),TO_DATE('2018-4-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-11-07 13:23:44','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','2018ca105g3@gmail.com',22244,'中央大學中央路255號','AB','有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Peter','123456','吳神','0919740601',TO_DATE('1982-02-02','YYYY-MM-DD'),TO_DATE('2018-6-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 11:25:51','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','2018ca105g3@gmail.com',22244,'中央大學中央路256號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Jim','123456','阿一','0919740601',TO_DATE('1983-03-03','YYYY-MM-DD'),TO_DATE('2018-5-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 15:36:11','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','2018ca105g3@gmail.com',22244,'中央大學中央路257號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Harry','123456','柯南','0919740601',TO_DATE('1984-04-04','YYYY-MM-DD'),TO_DATE('2018-4-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-25 16:54:54','yyyy-mm-dd hh24:mi:ss'),'停用','一般會員','男','2018ca105g3@gmail.com',22244,'中央大學中央路258號','A','有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Jay','123456','工藤','0919740601',TO_DATE('1985-05-05','YYYY-MM-DD'),TO_DATE('2018-8-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-04 16:25:15','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','男','2018ca105g3@gmail.com',22244,'中央大學中央路259號','B','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Kim','123456','晴子','0919740601',TO_DATE('1986-06-06','YYYY-MM-DD'),TO_DATE('2018-9-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 18:57:52','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','2018ca105g3@gmail.com',22244,'中央大學中央路260號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Adele','123456','結衣','0919740601',TO_DATE('1987-07-07','YYYY-MM-DD'),TO_DATE('2018-9-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-05 15:25:35','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','2018ca105g3@gmail.com',22244,'中央大學中央路261號','AB','有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Trista','123456','黑寡婦','0919740601',TO_DATE('1988-08-08','YYYY-MM-DD'),TO_DATE('2018-9-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-06 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','2018ca105g3@gmail.com',22244,'中央大學中央路262號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Alan','123456','美雪','0919740601',TO_DATE('1988-08-09','YYYY-MM-DD'),TO_DATE('2018-9-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-07 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','2018ca105g3@gmail.com',22244,'中央大學中央路263號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Blake','123456','Blake','0919740601',TO_DATE('1988-08-10','YYYY-MM-DD'),TO_DATE('2018-9-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-08 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','一般會員','女','2018ca105g3@gmail.com',22244,'中央大學中央路264號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Jack','123456','黑傑克','0919740601',TO_DATE('1988-08-11','YYYY-MM-DD'),TO_DATE('2018-9-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-09 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路265號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'KP','123456','柯文哲','0919740601',TO_DATE('1988-08-12','YYYY-MM-DD'),TO_DATE('2018-9-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-10 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路266號','B','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Zoe','123456','朝田龍太郎','0919740601',TO_DATE('1988-08-13','YYYY-MM-DD'),TO_DATE('2018-9-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-11 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路267號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Duke','123456','南方仁','0919740601',TO_DATE('1988-08-14','YYYY-MM-DD'),TO_DATE('2018-9-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-12 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路268號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Fast','123456','法斯特','0919740601',TO_DATE('1988-08-15','YYYY-MM-DD'),TO_DATE('2018-9-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路269號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Bob','123456','喬巴','0919740601',TO_DATE('1988-08-16','YYYY-MM-DD'),TO_DATE('2018-9-4 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-14 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路270號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Lin','123456','林杰樑','0919740601',TO_DATE('1988-08-17','YYYY-MM-DD'),TO_DATE('2018-9-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','男','2018ca105g3@gmail.com',22244,'中央大學中央路271號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Tess','123456','卯之花烈','0919740601',TO_DATE('1988-08-18','YYYY-MM-DD'),TO_DATE('2018-9-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','2018ca105g3@gmail.com',22244,'中央大學中央路272號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Girl','123456','綱手','0919740601',TO_DATE('1988-08-19','YYYY-MM-DD'),TO_DATE('2018-9-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','2018ca105g3@gmail.com',22244,'中央大學中央路273號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Queen','123456','慈悲','0919740601',TO_DATE('1988-08-20','YYYY-MM-DD'),TO_DATE('2018-9-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','醫療人員','女','2018ca105g3@gmail.com',22244,'中央大學中央路274號','B','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Aaron','123456','艾倫','0919740601',TO_DATE('1988-08-15','YYYY-MM-DD'),TO_DATE('2018-9-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-13 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','2018ca105g3@gmail.com',22244,'中央大學中央路269號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Ace','123456','艾斯','0919740601',TO_DATE('1988-08-16','YYYY-MM-DD'),TO_DATE('2018-9-4 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-14 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','2018ca105g3@gmail.com',22244,'中央大學中央路270號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Adolf','123456','阿道夫','0919740601',TO_DATE('1988-08-17','YYYY-MM-DD'),TO_DATE('2018-9-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-15 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','男','2018ca105g3@gmail.com',22244,'中央大學中央路271號','O','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Athena','123456','雅典娜','0919740601',TO_DATE('1988-08-18','YYYY-MM-DD'),TO_DATE('2018-9-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-16 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','2018ca105g3@gmail.com',22244,'中央大學中央路272號','AB','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Hannh','123456','天使佩涵','0919740601',TO_DATE('1999-08-19','YYYY-MM-DD'),TO_DATE('2018-9-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-17 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','2018ca105g3@gmail.com',22244,'中央大學中央路273號','A','沒有',NULL,NULL,NULL,NULL);
INSERT INTO MEMBER VALUES ('M'||lpad(to_char(member_seq.NEXTVAL), 4, '0'),'Keiko','123456','景子','0919740601',TO_DATE('1988-08-20','YYYY-MM-DD'),TO_DATE('2018-9-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2018-12-18 11:52:42','yyyy-mm-dd hh24:mi:ss'),'正常','餐飲業者','女','2018ca105g3@gmail.com',22244,'中央大學中央路274號','B','沒有',NULL,NULL,NULL,NULL);


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

INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','槌球比賽','桃園市中壢區中正公園',TO_DATE('2018-12-31','YYYY-MM-DD'),'已結束',10,3,1,'一年一度老人盃槌球大賽開始囉，歡迎報名!',NULL,24.960402,121.226430);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0008','外丹功宣導','桃園市中壢區精五行養身館',TO_DATE('2018-01-13','YYYY-MM-DD'),'已結束',30,2,1,'大家來練外丹功，健康一生，前程美好，幸福一生。',NULL,24.959477,121.218103);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0012','喝咖啡','桃園市中壢區沙皇風尚咖啡館',TO_DATE('2018-08-26','YYYY-MM-DD'),'已結束',5,2,1,'下午無聊沒事，想找人一起享受午後時光。',NULL,24.957615,121.212902);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0007','做公益','桃園市中壢區社會福利基金會',TO_DATE('2018-05-20','YYYY-MM-DD'),'已結束',20,5,1,'徵求長青工作者一起幫助弱家庭。',NULL,24.959594,121.206722);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0018','一起騎單車','桃園市永安漁港',TO_DATE('2018-09-01','YYYY-MM-DD'),'已結束',15,2,1,'永安漁港揪團騎，邀請朋友們陪我漫遊綠色隧道。',NULL,24.988651,121.014494);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','客家文化行','苗栗縣客家圓樓',TO_DATE('2018-10-01','YYYY-MM-DD'),'已結束',15,2,1,'客家人的文化，客家人的態度。',NULL,24.6034886,120.82331599999998);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0010','周年慶大採購','桃園市中壢區SOGO',TO_DATE('2019-10-11','YYYY-MM-DD'),'募集中',5,2,1,'這一波周年慶我一定要搶到GUGGI，有人有興趣陪我一起搶嗎?',NULL,24.962474,121.223562);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0019','象棋大賽','桃園市中壢區新勢公園',TO_DATE('2019-02-02','YYYY-MM-DD'),'募集中',2,1,1,'高處不勝寒，坐擁榕樹下20年，需要有人來打敗我，I want You!',NULL,24.951806,121.216693);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actdesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0013','定期體檢','桃園市中壢區佑民醫院',TO_DATE('2019-01-24','YYYY-MM-DD'),'募集中',50,10,1,'一年一度免費體檢開始囉，歡迎各位會員相約一起來。',NULL,24.957371,121.203808);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0009','看海景','三仙台',TO_DATE('2019-03-24','YYYY-MM-DD'),'募集中',30,10,1,'一起前往台東吧，風和日麗時的三仙台美到讓您忘記呼吸!',null,23.121648,121.402531);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','觀看空勤隊訓','豐年機場',TO_DATE('2019-02-24','YYYY-MM-DD'),'募集中',30,10,1,'可以看到空中勤務隊日常訓練，直升機各種高技術操作，保證驚叫連連喔!',null,22.756575,121.107225);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0002','甩手功大會','台北大學',TO_DATE('2019-01-24','YYYY-MM-DD'),'募集中',30,10,1,'招募附近居民與有意願者一起前往甩手健身!',null,24.946961,121.370697);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0020','拜訪地靈人傑區域','台中大雅區',TO_DATE('2019-04-24','YYYY-MM-DD'),'募集中',14,1,1,'聽說這裡專出人才? 大家一起前去看看吧!',null,24.222310,120.655814);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0004','一起看熱氣球','鹿野高台',TO_DATE('2019-03-13','YYYY-MM-DD'),'募集中',12,1,1,'台東鹿野高台熱氣球季盛況空前，大家一起前往欣賞熱氣球聚落同時升起的壯觀景色吧',null,22.917183,121.122715);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0006','岡山之眼一日遊','高雄岡山',TO_DATE('2019-01-25','YYYY-MM-DD'),'募集中',11,11,1,'羊肉爐好吃喔，一同前往大吃一頓吧!',null,22.804851,120.363713);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0011','紅豆麵包好好吃','台東關山',TO_DATE('2019-3-11','YYYY-MM-DD'),'募集中',15,10,1,'你知道關山有超好吃的紅豆吐司嗎? 大家一同前往選購吧!',null,23.016268,121.186018);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0013','大家以起來爬山','台北象山',TO_DATE('2019-6-12','YYYY-MM-DD'),'募集中',40,20,1,'身為都市人每日待在家身體都快腐朽啦，一起前往像山登山健行吧!',null,25.027906,121.576540);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0001','宅宅在幹嘛','新竹科學園區',TO_DATE('2019-01-27','YYYY-MM-DD'),'募集中',100,20,1,'看過宅宅嗎? 擔心這輩子沒見過宅宅顯得孤陋寡聞? 一同前往新竹科學園區見識宅宅們吧!',null,24.782585,121.006332);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0005','秋紅谷觀光','台中秋紅谷',TO_DATE('2019-4-22','YYYY-MM-DD'),'募集中',10,2,1,'秋紅谷位於台中市區，朋友們一同前來秋紅谷魚池釣魚吧!',null,24.167404,120.639722);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0007','麵超好吃','台南小丰川',TO_DATE('2019-5-11','YYYY-MM-DD'),'募集中',4,4,1,'上次在台南迷路，誤打誤撞走進一家叫小丰川的麵攤，隨意點了一碗麵，沒想到真是太好吃了! 大家一起相約前來享受美食吧!',null,22.999767,120.199701);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0013','美食的一天','台南國華街',TO_DATE('2019-8-12','YYYY-MM-DD'),'募集中',15,11,1,'想不想到台南美食一級戰區呢?一同來國華街享受美食吧!',null,2.996801,120.198625);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0015','漫遊安平','台南安平老街',TO_DATE('2019-2-24','YYYY-MM-DD'),'募集中',3,2,1,'想同時感受台南豔陽，台南文化與台南美食嗎? 一同前來安平老街吧!',null,23.000975,120.161896);
INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude) VALUES('ACT'||lpad(to_char(activity_seq.NEXTVAL), 4, '0'),'M0018','東區美食游','台南東區',TO_DATE('2019-3-15','YYYY-MM-DD'),'募集中',50,10,1,'台南東區居民一起前來聚會吧!',null,22.992663,120.221997);

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
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0001','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0001','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0005',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0002','M0008',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0005',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0003','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0005',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0004','M0008',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0005','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0006','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0006','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0007','M0020',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0008','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0009','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0009','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0009','M0016',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0009','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0009','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0009',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0010','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0011','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0011','M0006',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0012','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0012','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0012','M0020',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0020',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0004',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0009',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0016',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0013','M0008',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0004',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0014',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0014','M0009',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0015','M0006',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0015','M0016',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0015','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0015','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0002',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0008',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0020',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0004',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0016','M0010',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0017','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0017','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0017','M0003',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0018','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0018','M0020',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0018','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0018','M0012',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0019','M0005',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0019','M0011',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0019','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0020','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0020','M0017',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0020','M0016',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0020','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0021','M0013',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0021','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0021','M0014',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0022','M0015',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0022','M0007',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0022','M0001',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0023','M0018',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0023','M0019',1);
INSERT INTO joinact(actno,memno,joinstatus)VALUES('ACT0023','M0008',1);


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

INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'冠軍!','ACT0001','M0001','參加過這麼多次槌球比賽，還沒有像這次這麼順利，人生第一次的冠軍獎盃入手了!這都要感謝我的老伴不離不棄，每天陪我練習，愛妳歐。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'槌球初體驗','ACT0001','M0018','槌球真是很棒，人一開心的話就輕鬆了嘛，又可以結交一些朋友啊，對不對，大家在一起玩蠻開心的，參加這個運動太棒了!',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'外丹功十二式關鍵功效','ACT0002','M0010','外丹功可說是臺灣本土所發展出來的一種養生運動，是由一系列全身抖動，和諧地融合各種動作的招式所組成。它有氣功的內涵，也就是藉由抖動及振盪，自然地把人體先天之氣引發出來，再經由抖動及振盪讓先天之氣充貫全身。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'大家來練外丹功','ACT0002','M0012','坐姿外丹功的抖腳好處多多，長期多練，兩腿的肌肉Q彈、潤白、細嫰，光滑、帶電知覺感男女皆同。靜脈回流順暢就不會靜脈曲張，肝脾腎氣足，臟腑健康就少有三高!',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'外丹功減肥','ACT0002','M0005','人老珠黃，或步入中年變胖，大皆臟腑功能衰退之象。外丹功保健臟腑功法，舉例一二：預備式手腳先天氣來回，活絡十二經脈，保元培本之功。面東龜息吐納功，綿綿悠長，吐故納新，調理臟腑效果好。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'首選店家','ACT0003','M0002','服務很棒，我心裡最棒的服務不是 barista、店員把你當成家人般地親切，而是把客人看待為自己的朋友，當然也不是那種姐妹、換帖的好朋友，距離很剛好，就是會想要分享好東西、開心的事情、交換一些建議，最好不說話也不尷尬的。但是最重要最重要的就是一個笑容。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'煮咖啡初體驗','ACT0003','M0019','由於對於新鮮的堅持，所以必須在沖煮前才研磨咖啡豆，因此磨豆機就成了必要的工具，再此先提出一個很重要的觀念：好的磨豆機比好的咖啡機更重要！在追求好咖啡的道路上，一台夠水準的磨豆機是絕對必要的配備。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'咖啡品杯','ACT0003','M0011','品嚐好咖啡不但是要用舌頭的味覺去感受，還要享受咖啡留在口裡的芳醇，除此之外，所以在好好享受咖啡的同時，靜下心來品嚐好咖啡是一件非常微妙的事情，所以當你靜下心來品嘗好咖啡也是品嚐優質生活的一部份!!',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'做公益人人有責','ACT0004','M0007','通過參加公益活動，我結識了很多普普通通的人，我們是夥伴，我們是戰友。如果把公益事業比作一條路的話，那某些公益大腕就是引領大家前進的路標；而像我這樣的，就是那鋪路石。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'回饋社會','ACT0004','M0017','此次的勸募經驗, 給了我們一個機會奉獻一己之力, 我相信,我們是極為幸運的。有豐富的人生經驗,生活完滿且衣食無虞, 在募款活動中, 每幕到一筆金額, 便有一股暖流從心中油然而生,並讓我更貼近了社會弱勢的一群,從為他們發聲,幫助他們尋覓更好的生活環境',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'參與公益心得','ACT0004','M0019','我認為慈善就在我們身邊，隨手公益，大家都能參與進來。 比如肯德基的 「捐一元」項目，對於大眾來說只是隨手捐了一元，但小愛心匯聚成大暖流，9年來，「捐一元」累計從1億人次的消費者中募集了1.5億元，為18.6萬人次的貧困山區小學生提供了近3000萬份「牛奶+雞蛋」的營養餐。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'為什麼要做公益','ACT0004','M0001','「公益」，不是看你捐了多少錢，「公益」是你喚醒了多少人的愛心。「公益」的核心思想就是喚醒良知，喚醒善良。給乾渴的花朵倒一口水。給流浪的貓狗一些剩飯剩菜。給風雪中的麻雀撒一點麵包渣。給困惑的人一個微笑。給迷茫的人一個方向。這些雖是「舉手之勞」卻能溫暖人心。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'綠色隧道漫遊','ACT0005','M0001','新屋綠色走廊　感受大自然風光，桃園綠色走廊為北台灣最具規模自行車遊憩區，全長５公里，由綠蔭大道及濱海道路所組成，設有木棧平台、觀海亭、漂流木公園等設施，民眾只要騎上自行車馳騁其中，綠林或藍海間都能享受自然洗禮。',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'快樂出遊','ACT0005','M0007','明明知道天氣熱到爆炸，但喜歡騎腳踏車，所以，我們還是捨熱去永安綠色隧道騎腳踏車，看看天熱汗流多多後，我能不能瘦個幾公斤．．．哈哈！',NULL,NULL,'文字心得');
INSERT INTO impression VALUES ('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),'漁港吃一波','ACT0005','M0017','永安漁港近年規劃建設變化真的很大，尤其觀海橋的落成，晚上五點都會開啟七彩LED燈，延長興建原有防波提，挖深航道，讓人更好在這停放車輛。',NULL,NULL,'文字心得');

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

INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0021','孫小美','愛的廚房',NULL,'人家最擅長的就是愛的料理','啓用','03987456','中央大學內','阿土伯');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0022','超級鯉魚王','生猛海鮮',NULL,'全宇宙最生猛的海鮮','啓用',756629600,'西太平洋馬里亞那海溝','波賽頓');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0023','小噹家','洋泉大酒家',NULL,'廣東省廣州市最具知名的第一餐館，中壢分館是邁向征服全世界的海外首間分館','啓用',11469883,'四川省成都','及第師傅');
INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0024','老皮','真心料理',NULL,'今年10歲，卻擁有21年料理經歷的男人','啓用',55469883,'真心鎮','小小智');

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

INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0003','60','滿漢全席',NULL,'可送餐','一生一定要吃一次');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','600','滿漢全席',NULL,'可送餐','一生一定要吃一次');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','20','燒肉飯桶',NULL,'可送餐','保證沒有豬瘟的燒肉');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','30','宅男咖哩',NULL,'可送餐','不是宅男也會愛上的咖哩');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','50','珍珠爆乳茶',NULL,'可送餐','塑身效果十足');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','60','飛天紅豆湯',NULL,'可送餐','好喝到飛天');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','99','火焰炸雞',NULL,'可送餐','吃了會噴火der');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','138','阿嬤漢堡',NULL,'可送餐','連我阿嬤都愛吃');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','199','尼古丁比薩',NULL,'可送餐','絕對會上癮，快來試一試');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','66','昇天河豚鍋',NULL,'可送餐','新品種無毒河豬鍋');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','45','氫酸鉀咖啡',NULL,'可送餐','助眠效果一流！');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','87','超級三寶飯',NULL,'可送餐','不是那個三寶的三寶飯');

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

INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190123','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190124','YYYYMMDD'),'午');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190220','YYYYMMDD'),'晚');
INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'),to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.CURRVAL), 4, '0'),TO_DATE('20190221','YYYYMMDD'),'晚');

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

INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','威尼斯影城','CHEF0001','接受',current_timestamp);

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
--  醫療人員M11D1
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0011',
'本名間黑男，從小父親因婚外情而私奔及離棄他及母親，因此和母親一起生活。
某日與母親出遊，因工程商的人為疏失，他誤觸未爆彈引發爆炸，母親送醫後不治，他也一度瀕死，
但終於被擁有高明醫術的本間丈太郎醫師救活。
痛苦的復健過程中，使他活下去的動力只有兩個：成為和本間醫師一樣的一流外科醫師，以及報復害死母親的工程商關係人。
若干年後，間黑男果真習得世界頂尖的外科技術，不過由於對醫學的理念不見容於醫學界，醫師執照被吊銷，
但他仍憑其高超的醫術自己開診所，並向病患收取鉅額手術費。          
人們稱這位無照行醫的外科天才為：黑傑克。
','線上','生效中','外科','888',NULL);
--------------------------------------------------------
--  醫療人員M12D2
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0012',
'中華民國外科醫師、無黨籍政治人物，現任臺北市市長。
國立臺灣大學醫學院臨床醫學研究所博士畢業，曾任臺大醫院急診部醫師、臺大醫院創傷醫學部主任、臺大醫學院教授，
專長為外科重症醫學、器官移植 、人工器官等，是臺灣第一個急診與重症加護專職醫生，
為臺灣器官標準移植程序的建立者，也是首位將葉克膜（ECMO）技術引進臺灣的醫師。
','離線','生效中','外科','666',NULL);
--------------------------------------------------------
--  醫療人員M13D3
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0013',
'人稱「醫龍」，
性格獨斷獨行，對不當的醫療行為絕不袖手旁觀並予以糾正。
朝田很喜愛吃甜食，除了動手術的時候，身上幾乎隨時帶著甜食，甚至咖啡只要經過朝田的手，都會甜到不能喝的程度。
擁有影響他人的絕對魅力，為了讓團隊中的其他成員不再依賴自己，亦做出許多令人意想不到的舉動。
','離線','生效中','外科','111',NULL);
--------------------------------------------------------
--  醫療人員M14D4
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0014',
'意外穿越時空，從現代回到150年前的江戶地區。
即使在艱困的環境下，仍竭盡所能醫治病患。
雖然內心明白「拯救江戶百姓=改變歷史」，但看著努力求生的病患，自己也在不知不覺中，決定要在這個時代好好活下去。
','離線','生效中','腦外科','222',NULL);
--------------------------------------------------------
--  醫療人員M15D5
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0015',
'和鄰居的女兒艾莉莎是青梅竹馬，與其結婚後經營著一家診所，平靜而幸福的生活著。
突然有一天不幸降臨，瘋狂的歹徒槍殺了艾莉莎，浮士德千方百計想挽救妻子的生命，卻最終沒有戰勝死神。
從此性格變得極端而扭曲，為了將死去的愛妻艾莉莎復活而參加通靈王激戰。
在禮貌的言語下面，掩飾著一旦切下去就不會罷手的性格。
','離線','生效中','外科','333',NULL);
--------------------------------------------------------
--  醫療人員M16D6
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0016',
'草帽海賊團的船醫。他是一隻有藍鼻子的馴鹿，因為吃下的「人人果實」讓他得到了能變成人類或半人半鹿的超能力。
雖然身為海賊，但也堅持醫生的立場，總是給予每個經手的病人確實的治療，也因此痛恨將人命玩弄於股掌間的行為。
有時能夠利用自己豐富的醫療學識，為夥伴開啟勝利之路，夢想是透過學習醫術而讓自己成為萬靈藥。
','離線','生效中','外科','555',NULL);
--------------------------------------------------------
--  醫療人員M17D7
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0017',
'臺灣著名的腎臟科和毒理學醫生，有「毒物科權威」之稱，
林杰樑出生於中華民國嘉義縣朴子市的醫學世家，畢業後長期投入腎臟醫學與毒物醫學的研究。
他也是首位研發出農藥百草枯解毒劑並且建立標準急救流程的醫生，成功降低臺灣早期許多攝入農藥而致死的案例。
其研發的治療方式推廣至世界各地且廣泛獲得運用後，也讓原本農藥中毒存活率為40%的印度上升至80%左右。
同時長期致力於向民眾宣導正確飲食、防毒養生與各項醫學觀念。
','離線','生效中','腎臟科','1111',NULL);
--------------------------------------------------------
--  醫療人員M18D8
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0018',
'外貌溫柔仁慈，蓄著中分的黑色長髮，
由於她的鎖骨正下方，有片從入隊以來唯一留下的傷疤，所以平常總是將頭髮綁成麻花髮辮並垂至前方。
擔當救護隊隊長，醫術極其高超，對護廷十三隊隊員和藹，
但對在醫護所大鬧的人則會對其散發出其可怕的殺氣，甚至連十一番隊的人都被她嚇得不敢反駁。
倘若旗下成員因故違反屍魂界的規範，則會讓對方接受應有的處分。
','離線','生效中','家醫科','2222',NULL);
--------------------------------------------------------
--  醫療人員M19D9
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0019',
'木葉忍者村第五代火影、首位女火影。
第一代火影「千手柱間」的孫女，為傳說三忍之一（另外兩位為自來也和大蛇丸），忍界極富盛名的醫療忍者。
同時也是建議任務小隊需要一名醫療忍者隨行的首倡者。
','離線','生效中','家醫科','3333',NULL);
--------------------------------------------------------
--  醫療人員M20D10
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0020',
'慈悲，原名安吉拉•齊格勒，是一名頂尖的治療者、出色的科學家和堅定的和平主義者。
齊格勒在踏入可以極大改善致命疾病和損傷治療效果的突破性應用納米生物學領域之前，是瑞士一家頂尖醫院的手術部門負責人。
正是她在醫學領域的成就，引起了鬥陣特攻的注意，受邀擔任醫學研究部門的負責人。
安吉拉致力於更好地在前線治療受到致命傷的病員。
而當鬥陣特攻解散之後，齊格勒博士便致力於幫助那些受戰爭波及的受難者。
','離線','生效中','家醫科','99',NULL);
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

INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0001',TO_DATE('20190101','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0001',TO_DATE('20190201','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0002',TO_DATE('20190101','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0002',TO_DATE('20190201','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0003',TO_DATE('20190101','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0003',TO_DATE('20190201','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0004',TO_DATE('20190101','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0004',TO_DATE('20190201','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0005',TO_DATE('20190101','YYYYMMDD'),'011010011100100111001110100111111011111100100011111001000001111111100001111010000100100111110');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0005',TO_DATE('20190201','YYYYMMDD'),'011010011100100111001110100111111011111100100011111001000001111111100001111010000100100111110');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0006',TO_DATE('20190101','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0006',TO_DATE('20190201','YYYYMMDD'),'000011000111110001110110110111111001000101100100010010100111101101001001100001001010100101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0007',TO_DATE('20190101','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0007',TO_DATE('20190201','YYYYMMDD'),'111011100101010010011100100010010111011001010010000111001101101001101111011010101100110010001');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0008',TO_DATE('20190101','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0008',TO_DATE('20190201','YYYYMMDD'),'010001110100011111000001100110101011010011100000101000010110001011010110010000011101100101000');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0009',TO_DATE('20190101','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0009',TO_DATE('20190201','YYYYMMDD'),'001110001000111011111010000110010010010001100010010010001101110011011000011010110100010101100');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0010',TO_DATE('20190101','YYYYMMDD'),'011010011100100111001110100111111011111100100011111001000001111111100001111010000100100111110');
INSERT INTO doctoravailable VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),'D0010',TO_DATE('20190201','YYYYMMDD'),'011010011100100111001110100111111011111100100011111001000001111111100001111010000100100111110');


commit;


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
    CONSTRAINT chk_mostatus CHECK (mostatus IN('等待問診','問診完成','取消問診')),
    CONSTRAINT chk_mohour CHECK (mohour IN('9','13','17'))
);

CREATE SEQUENCE medicalorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','問診完成',666,to_date('20181001','YYYYMMDD'),9,'心臟疼痛不止',null,null,'建議到大型醫院檢查');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','等待問診',666,to_date('20181002','YYYYMMDD'),13,'晚上睡不著，白天一直睡',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0003','問診完成',111,to_date('20181003','YYYYMMDD'),17,'蚊子叮咬',null,null,'開藥藥給你擦');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0003','D0003','等待問診',111,to_date('20181004','YYYYMMDD'),9,'頭皮發癢',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0004','D0004','問診完成',222,to_date('20181005','YYYYMMDD'),13,'白天不會咳，躺下睡覺一直咳',null,null,'藥劑三餐飯後+睡前吃');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0005','D0005','取消問診',333,to_date('20181006','YYYYMMDD'),17,'眼睛痛','臨時有事',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0006','D0004','等待問診',222,to_date('20181007','YYYYMMDD'),9,'耳朵會流出臭臭的不明液體，耳屎挖出來有血色',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0007','D0006','等待問診',555,to_date('20181008','YYYYMMDD'),13,'心情低落，做什麼事都提不起勁，想死',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0008','D0001','問診完成',888,to_date('20181001','YYYYMMDD'),17,'肩膀疼痛',null,null,'建議到大型醫院檢查');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0008','D0001','等待問診',888,to_date('20181002','YYYYMMDD'),9,'走久了膝蓋會疼痛',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0009','D0007','問診完成',1111,to_date('20181003','YYYYMMDD'),13,'蚊蟲叮咬後紅腫不消',null,null,'開藥藥給你擦');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0009','D0007','等待問診',1111,to_date('20181004','YYYYMMDD'),17,'頭皮發癢數日未見改善',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0010','D0008','問診完成',222,to_date('20181005','YYYYMMDD'),9,'白天不會咳，躺下睡覺一直咳',null,null,'藥劑三餐飯後+睡前吃');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0010','D0008','取消問診',2222,to_date('20181006','YYYYMMDD'),13,'脖子僵硬','自行按摩解決',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0009','等待問診',3333,to_date('20181007','YYYYMMDD'),17,'經期不順',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0010','等待問診',99,to_date('20181008','YYYYMMDD'),9,'尿尿會起泡',null,null,null);
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

