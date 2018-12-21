INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','中央大學','CHEF0001','接受',to_date('2019-10-02','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','中央大學','CHEF0001','接受',to_date('2019-10-03','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0001','中央大學','CHEF0001','審核中',to_date('2019-01-25','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0002','台東知本','CHEF0001','接受',to_date('2019-02-22','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0002','台東知本','CHEF0001','接受',to_date('2019-02-23','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0003','台南新營','CHEF0001','審核中',to_date('2019-01-10','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0003','台南新營','CHEF0001','接受',to_date('2019-10-02','yyyy-MM-dd'));
INSERT INTO foodorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),'M0004','高雄仁武','CHEF0002','已取消',to_date('2019-10-02','yyyy-MM-dd'));
COMMIT;