--------------------------------------------------------
--  insert into doctor
--------------------------------------------------------
--------------------------------------------------------
--  醫療人員1
--------------------------------------------------------
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0016','台大醫學系畢業

前台大醫院醫師

前衛生署醫策會委員

美國醫師考試FMGEMS及格

前秀傳醫院皮膚科專任醫師

台大糖尿病衛教小組訓練','線上','生效中','家醫科','9487',NULL);

--------------------------------------------------------
--  醫療人員2
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0017','國泰綜合醫院皮膚科暨醫學美容中心主治醫師
內湖國泰綜合醫院皮膚科主治醫師
汐止國泰綜合醫院皮膚科主治醫師
新竹國泰綜合醫院皮膚科主治醫師
中華民國皮膚科專科醫師
台灣皮膚科醫學會會員','線上','生效中','皮膚科','9999',NULL);

--------------------------------------------------------
--  醫療人員3
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
--  醫療人員4
--------------------------------------------------------

INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0019','前署立台北醫院主任醫師
前台大主治醫師(兼任)
健保門診主治醫師(兼任)
美國John-Hopkins眼科中心 / 雷射近視矯正術研修
現任大愛眼科執行長','線上','生效中','眼科','8888',NULL);
INSERT INTO doctor VALUES ('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),'M0020','【我們心理諮商所】合作心理師

--------------------------------------------------------
--  醫療人員5
--------------------------------------------------------
【龍華科技大學】專任諮商心理師
【新北市泰山高中】專任輔導教師
【新北市泰山區】國小專任輔導教師
​【亞東醫院精神科自殺防治中心】輔導員
【新北市厚德國小】高風險家庭團體帶領者
【法務部矯正署台北監獄】性侵加害人團體觀察員','線上','生效中','心理諮商','6666',NULL);


-----------------------------------------------
-- insert into administrator
-----------------------------------------------
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'可新增管理員','生效中',TO_DATE('2018-11-11','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'可新增管理員','生效中',TO_DATE('2018-11-12','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'一般管理員','生效中',TO_DATE('2018-11-13','YYYY-MM-DD'));
INSERT INTO administrator VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),'一般管理員','生效中',TO_DATE('2018-11-14','YYYY-MM-DD'));

-----------------------------------------------
-- insert into medicalorder
-----------------------------------------------
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','問診完成',9487,to_date('20181001','YYYYMMDD'),'心臟疼痛不止',null,'建議到大型醫院檢查');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','等待問診',9487,to_date('20181002','YYYYMMDD'),'晚上睡不著，白天一直睡',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0003','問診完成',9999,to_date('20181003','YYYYMMDD'),'蚊子叮咬',null,'開藥藥給你擦');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0003','D0003','等待問診',9999,to_date('20181004','YYYYMMDD'),'頭皮發癢',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0004','D0004','問診完成',7777,to_date('20181005','YYYYMMDD'),'白天不會咳，躺下睡覺一直咳',null,'藥劑三餐飯後+睡前吃');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0005','D0005','取消問診',8888,to_date('20181006','YYYYMMDD'),'眼睛痛',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0006','D0004','等待問診',7777,to_date('20181007','YYYYMMDD'),'耳朵會流出臭臭的不明液體，耳屎挖出來有血色',null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0007','D0006','等待審核',6666,to_date('20181008','YYYYMMDD'),'心情低落，做什麼事都提不起勁，想死',null,null);

-----------------------------------------------
-- insert into favdr
-----------------------------------------------
INSERT INTO favdr (memno,drno) VALUES ('M0007','D0006');
INSERT INTO favdr (memno,drno) VALUES ('M0007','D0002');
INSERT INTO favdr (memno,drno) VALUES ('M0001','D0003');
INSERT INTO favdr (memno,drno) VALUES ('M0003','D0005');
INSERT INTO favdr (memno,drno) VALUES ('M0003','D0004');
-----------------------------------------------
-- insert into reportdr
-----------------------------------------------
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0004','D0001','病歷表亂寫',current_timestamp,'已處理');
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0005','D0001','看病很隨便',current_timestamp,'未處理');




