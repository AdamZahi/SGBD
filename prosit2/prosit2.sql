-- Ref_contrat sequence
CREATE SEQUENCE seq_ref_contrat INCREMENT BY 1 START WITH 104 ;
-- Insert a row to launch the sequence
insert into contrat_vente (ref_contrat,cin,immatriculation,date_vente,prix_vente)
    values(To_char(ref_contrat.seq_ref_contrat.nextval) ,'11829389','2017TN1669',sysdate,15000);

--Create the vehicles view
CREATE VIEW vehicules_more_10000 AS 
    SELECT * FROM contrat_ventes 
    WHERE prix_vente > 10000
    WITH readonly;

CREATE VIEW managed_vehicles AS
    SELECT * FROM vehicules
    WHERE extract(year from sysdate - to_number(To_char(date_mise_circulation,'yyyy'))) <= 3
    WITH checkoption;

-- Create an index on the vehicle table (prix_demande)
CREATE index idx on vehicules(prix_demande);