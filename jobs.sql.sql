INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Mesai dışı LSPD'),
  ('offambulance','Mesai dışı LSMD')
  ('offsheriff','Mesai dışı LSSD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Recruit',100,'{}','{}'),
  ('offpolice',1,'officer','Officer',100,'{}','{}'),
  ('offpolice',2,'sergeant','Officer II',100,'{}','{}'),
  ('offpolice',3,'intendent','Officer III',100,'{}','{}'),
  ('offpolice',4,'lieutenant','Sergeant',100,'{}','{}'),
  ('offpolice',5,'chef','Lieutenant',100,'{}','{}'),
  ('offpolice',6,'chef','Captain',100,'{}','{}'),
  ('offpolice',7,'chef','Commander',100,'{}','{}'),
  ('offpolice',8,'chef','Major',100,'{}','{}'),
  ('offpolice',9,'chef','Deputy Chief',100,'{}','{}'),
  ('offpolice',10,'boss','Chief Of Police',100,'{}','{}'),
  ('offpolice',11,'sergeant','Helicopter Operator',100,'{}','{}'),
  ('offambulance',0,'ambulance','Stajyer Doktor',100,'{}','{}'),
  ('offambulance',1,'doctor','Doktor',100,'{}','{}'),
  ('offambulance',2,'chief_doctor','Uzman Doktor',100,'{}','{}'),
  ('offambulance',3,'chief_doctor','Doçent Doktor',100,'{}','{}'),
  ('offambulance',4,'chief_doctor','Prof Doktor',100,'{}','{}'),
  ('offambulance',5,'boss','Baş Hekim Yardımcısı',100,'{}','{}'),
  ('offambulance',6,'boss','Baş Hekim',100,'{}','{}'),
  ('offambulance',7,'heli','Helikopter Operatörü',100,'{}','{}'),
  ('offsheriff',0,'recruit','Stajyer Officer',100,'{}','{}'),
  ('offsheriff',1,'officer','Officer',100,'{}','{}'),
  ('offsheriff',2,'sergeant','Ranger',100,'{}','{}'),
  ('offsheriff',3,'lieutenant','Teğmen',100,'{}','{}'),
  ('offsheriff',4,'chef','Deputy',100,'{}','{}'),
  ('offsheriff',5,'boss','Sheriff',100,'{}','{}')
;
