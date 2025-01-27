-- Delete table if exists
drop table models cascade constraints ;
drop table vehicules cascade constraints ;
drop table personnes cascade constraints ;
drop table acquisitions cascade constraints ;
drop table contrat_ventes cascade constraints ;

-- create models table
CREATE TABLE models(
    ref_model varchar2(30) constraint pk_model primary key,
    modele varchar2(30) constraint nt_modele not null,
    marque varchar2(30) constraint nt_marque not null,
    puissance varchar2(30) constraint nt_puissance not null
); 

-- create models vehicules
CREATE TABLE vehicules(
    immatriculation varchar2(30) constraint pk_vehicule primary key,
    ref_model varchar2(30) constraint nt_ref_model not null,
    date_mise_circulation date constraint nt_date not null,
    kilometrage number constraint nt_kilometrage not null,
    prix_demande number constraint nt_prix_demande not null,
    constraint fk_vehicule foreign key (ref_model) references models(ref_model)
);

-- create persons table
CREATE TABLE personnes(
    cin varchar2(15) constraint pk_cin primary key,
    nom varchar2(30) constraint nt_nom not null constraint ck_nom check(regexp_like(nom,'[a-z]') and regexp_like(nom,'[A-Z]')),
    prenom varchar2(30) constraint nt_prenom not null,
    email varchar2(50) constraint nq_email unique constraint ck_email check(email like '%@%.%'),
    num_tel number constraint nq_tel unique
);

-- create acquisitions table
CREATE TABLE acquisitions (
    immatriculation varchar2(30),
    cin varchar2(15),
    date_debut date ,
    date_fin date not null,
    constraint ck_date check (date_fin > date_debut),
    constraint pk_acquisition primary key (immatriculation, cin),
    constraint fk1_immatriculation foreign key(immatriculation) references vehicules(immatriculation),
    constraint fk1_cin foreign key(cin) references personnes(cin)
);

-- create contrat_ventes table
CREATE TABLE contrat_ventes (
    ref_contrat varchar2(30),
    immatriculation varchar2(30),
    cin varchar2(15),
    date_vente date default sysdate ,
    prix_vente number constraint nt_prix not null constraint ck_prix check(prix_vente > 0),
    constraint pk_contrat primary key (ref_contrat,immatriculation,cin),
    constraint fk2_immatriculation foreign key(immatriculation) references vehicules(immatriculation),
    constraint fk2_cin foreign key(cin) references personnes(cin)
);


