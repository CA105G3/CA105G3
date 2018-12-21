INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','150','佛跳牆',NULL,'不可送餐');
INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001','80','脆皮燒鴨飯',NULL,'可送餐');
COMMIT;