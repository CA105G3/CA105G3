-----------------------------------------------
-- insert into medicalorder
-----------------------------------------------
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','問診完成',9487,to_date('20181001','YYYYMMDD'),'心臟疼痛不止',null,null,'建議到大型醫院檢查');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0001','D0002','等待問診',9487,to_date('20181002','YYYYMMDD'),'晚上睡不著，白天一直睡',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0002','D0003','問診完成',9999,to_date('20181003','YYYYMMDD'),'蚊子叮咬',null,null,'開藥藥給你擦');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0003','D0003','等待問診',9999,to_date('20181004','YYYYMMDD'),'頭皮發癢',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0004','D0004','問診完成',7777,to_date('20181005','YYYYMMDD'),'白天不會咳，躺下睡覺一直咳',null,null,'藥劑三餐飯後+睡前吃');
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0005','D0005','取消問診',8888,to_date('20181006','YYYYMMDD'),'眼睛痛',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0006','D0004','等待問診',7777,to_date('20181007','YYYYMMDD'),'耳朵會流出臭臭的不明液體，耳屎挖出來有血色',null,null,null);
INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),'M0007','D0006','等待審核',6666,to_date('20181008','YYYYMMDD'),'心情低落，做什麼事都提不起勁，想死',null,null,null);

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
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0004','D0001','病歷表亂寫',current_timestamp,'未處理');
INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),'M0005','D0001','看病很隨便',current_timestamp,'未處理');


commit;


