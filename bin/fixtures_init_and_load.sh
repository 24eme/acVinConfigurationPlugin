#!/bin/bash

cd $(dirname $0)/..

DBNAME=$(cat project/config/databases.yml | grep -A 4 couchdb | grep dbname | sed 's/.*:  *//')
DBURL=$(cat project/config/databases.yml  | grep -A 4 couchdb | grep dsn | sed 's/.*:  *//')

if ! curl -s $DBURL$DBNAME | grep true > /dev/null ; then
	curl -s -X PUT $DBURL$DBNAME
fi

curl -s -X PUT -d '{"_id": "COMPTE-7523700100", "type": "Compte","identifiant": "7523700100","civilite": null,"prenom": null,"nom": "M. Actualys Jean","nom_a_afficher": "M. Actualys Courtier","fonction": null,"commentaire": null,"origines": ["SOCIETE-7523700100"],"id_societe": "SOCIETE-7523700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "75001","commune": "PARIS","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-7523700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-7523700100", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "7523700100", "id_societe": "SOCIETE-7523700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-7523700100", "num_interne": null, "raison_sociale": "M. Actualys Courtier", "nom": "M. Actualys Courtier", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "COURTIER", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "75001", "commune": "PARIS" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null } }' $DBURL$DBNAME/ETABLISSEMENT-7523700100

curl -s -X PUT -d '{ "_id": "SOCIETE-7523700100", "type": "Societe", "identifiant": "7523700100", "type_societe": "COURTIER", "raison_sociale": "M. Actualys Courtier", "raison_sociale_abregee": "Actualys Courtier", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "75001", "commune": "Paris", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-7523700100", "contacts": { "COMPTE-7523700100": { "nom": "M. Actualys Courtier", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-7523700100": { "nom": "M. Actualys Courtier", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-7523700100

curl -s -X PUT -d '{"_id": "COMPTE-7823700100", "type": "Compte","identifiant": "7823700100","civilite": null,"prenom": null,"nom": "M. Actualys Viti","nom_a_afficher": "M. Actualys Viti","fonction": null,"commentaire": null,"origines": ["SOCIETE-7823700100"],"id_societe": "SOCIETE-7823700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "78100","commune": "ST GERMAIN","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-7823700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-7823700100", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "7823700100", "id_societe": "SOCIETE-7823700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-7823700100", "num_interne": null, "raison_sociale": "M. Actualys Jean", "nom": "M. Actualys Viti", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "PRODUCTEUR", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "78100", "commune": "ST GERMAIN" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null } }' $DBURL$DBNAME/ETABLISSEMENT-7823700100

curl -s -X PUT -d '{ "_id": "SOCIETE-7823700100", "type": "Societe", "identifiant": "7823700100", "type_societe": "PRODUCTEUR", "raison_sociale": "M. Actualys Viti", "raison_sociale_abregee": "Actualys Viti", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "78100", "commune": "St Germain", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-7823700100", "contacts": { "COMPTE-7823700100": { "nom": "M. Actualys Viti", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-7823700100": { "nom": "M. Actualys Viti", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-7823700100

curl -s -X PUT -d '{"_id": "COMPTE-9223700100", "type": "Compte","identifiant": "9223700100","civilite": null,"prenom": null,"nom": "M. Actualys Négo","nom_a_afficher": "M. Actualys Négo","fonction": null,"commentaire": null,"origines": ["SOCIETE-9223700100"],"id_societe": "SOCIETE-9223700100","adresse_societe": 1,"adresse": "Le Giron","adresse_complementaire": null,"code_postal": "92100","commune": "BOULOGNE","compte_type": "SOCIETE","cedex": null,"pays": "FR","email": "contact@actualys.com","telephone_perso": "","telephone_bureau": "01.00.00.00.00","telephone_mobile": "01.00.00.00.00","fax": "","interpro": "INTERPRO-declaration","statut": "ACTIF","tags": {"automatique": ["societe"]},"droits": ["transactions"]}' $DBURL$DBNAME/COMPTE-9223700100

curl -s -X PUT -d '{ "_id": "ETABLISSEMENT-9223700100", "type": "Etablissement", "cooperative": null, "interpro": "INTERPRO-declaration", "identifiant": "9223700100", "id_societe": "SOCIETE-9223700100", "statut": "ACTIF", "raisins_mouts": null, "exclusion_drm": null, "relance_ds": null, "recette_locale": { "id_douane": null, "nom": null, "ville": null }, "region": "HORS_REGION", "type_dr": null, "liaisons_operateurs": { }, "site_fiche": null, "compte": "COMPTE-9223700100", "num_interne": null, "raison_sociale": "M. Actualys Négo", "nom": "M. Actualys Viti", "cvi": null, "no_accises": null, "carte_pro": null, "famille": "NEGOCIANT", "sous_famille": "CAVE_PARTICULIERE", "email": null, "telephone": null, "fax": null, "commentaire": null, "siege": { "adresse": "Le Giron", "code_postal": "92100", "commune": "PARIS" }, "comptabilite": { "adresse": null, "code_postal": null, "commune": null } }' $DBURL$DBNAME/ETABLISSEMENT-9223700100

curl -s -X PUT -d '{ "_id": "SOCIETE-9223700100", "type": "Societe", "identifiant": "9223700100", "type_societe": "NEGOCIANT", "raison_sociale": "M. Actualys Négo", "raison_sociale_abregee": "Actualys Négo", "statut": "ACTIF", "code_comptable_client": null, "code_comptable_fournisseur": null, "code_naf": null, "siret": null, "interpro": "INTERPRO-declaration", "no_tva_intracommunautaire": null, "email": "actualys@example.org", "telephone": "01.00.00.00.00", "fax": "", "commentaire": null, "siege": { "adresse": "rue Garnier", "code_postal": "92100", "commune": "St Germain", "pays": "FR" }, "cooperative": null, "enseignes": [ ], "compte_societe": "COMPTE-9223700100", "contacts": { "COMPTE-9223700100": { "nom": "M. Actualys Négo", "ordre": 0 } }, "etablissements": { "ETABLISSEMENT-9223700100": { "nom": "M. Actualys Négo", "ordre": null } }, "date_modification": "2015-02-20" }' $DBURL$DBNAME/SOCIETE-9223700100

curl -s -X PUT -d '{ "_id": "CONFIGURATION", "type": "Configuration", "campagne": null, "labels": { "agriculture_biologique": "Agriculture Biologique" }, "contenances": { "75 cl": 0.0075, "1 L": 0.01, "1.5 L": 0.015, "3 L": 0.03, "BIB 3 L": 0.03, "6 L": 0.06 }, "droits": { "CVO": "Cvo" }, "libelle_detail_ligne": { "stocks_debut": { "instance": "En instance de revendication", "bloque": "Bloqué", "revendique": "Stock revendiqué dbt de mois" }, "entrees": { "achat": "Achat", "recolte": "Revendiqué", "transfert": "Transfert", "cooperative": "Coopérative", "reintegration": "Réintégration", "elaboration": "Elaboration", "repli": "Replis", "regularisation": "Régularisation", "fermagemetayage": "Fermage/Métayage" }, "sorties": { "export": "Export", "vracsanscontrat": "Vrac sans contrat", "vrac": "Contrat vrac ou conditionné", "bib": "Conditionné BIB", "bouteille": "Conditionné Bouteilles", "consommation": "Consommation personnelle", "distillation": "Distillation", "fermagemetayage": "Fermage/Métayage", "repli": "Replis", "declassement": "Déclassement", "cooperative": "Coopérative", "cession": "Cession", "elaboration": "Elaboration", "regularisation": "Régularisation" }, "stocks_fin": { "revendique": "Stock revendiqué fin de mois", "instance": "En instance de revendication", "bloque": "Bloqué" } }, "alias": { }, "declaration": { "certifications": { "AOC": { "libelle": "AOC", "format_libelle": "%g% %a% %m% %l%", "code": "AOC", "code_produit": null, "code_comptable": null, "code_douane": null, "departements": [ ], "interpro": { "declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } }, "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "genres": { "TRANQ": { "libelle": null, "format_libelle": null, "code": "TRANQ", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ { "date": "1900-01-01T00:00:00+01:00", "taux": 4.5, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "appellations": { "ANJ": { "libelle": "Actualys", "format_libelle": "%g% %a% %m% %l% %co%", "code": "ACT", "code_produit": null, "code_comptable": null, "code_douane": null, "densite": "1.3", "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "mentions": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "lieux": { "GAR": { "libelle": "Côteaux Garnier", "format_libelle": null, "code": "GAR", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1001", "code_comptable": "1", "code_douane": "" } } }, "rouge": { "libelle": "Rouge", "format_libelle": null, "code": "1", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1002", "code_comptable": "2", "code_douane": "" } } } } }, "SAB": { "libelle": "Côteaux Sablons", "format_libelle": null, "code": "SAB", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1003", "code_comptable": "3", "code_douane": "" } } }, "rouge": { "libelle": "Rouge", "format_libelle": null, "code": "1", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1004", "code_comptable": "4", "code_douane": "" } } } } } } } } } } }, "EFF": { "libelle": "Crémant", "format_libelle": "%g% %a% %m% %l%", "code": "EFF", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ { "date": "1900-01-01T00:00:00+01:00", "taux": 4, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "appellations": { "ACT": { "libelle": "Actualys", "format_libelle": null, "code": "ACT", "code_produit": null, "code_comptable": null, "code_douane": null, "densite": "1.3", "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ { "date": "1900-01-01", "taux": 3.8, "code": "CVO", "libelle": "Cvo" } ] } } }, "departements": [ ], "mentions": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "lieux": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "couleurs": { "blanc": { "libelle": "Blanc", "format_libelle": null, "code": "3", "code_produit": null, "code_comptable": null, "code_douane": null, "interpro": { "INTERPRO-declaration": { "labels": [ ], "droits": { "douane": [ ], "cvo": [ ] } } }, "departements": [ ], "cepages": { "DEFAUT": { "libelle": null, "format_libelle": null, "code": null, "code_produit": "1005", "code_comptable": "5", "code_douane": "" } } } } } } } } } } } } } }, "detail": { "stocks_debut": { "revendique": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 }, "instance": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 }, "bloque": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 } }, "entrees": { "achat": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "recolte": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "transfert": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "cooperative": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "reintegration": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 1 }, "elaboration": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "repli": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "regularisation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 }, "fermagemetayage": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": 1, "vrac": 0, "facturable": 0 } }, "sorties": { "export": { "readable": 1, "writable": 1, "details": 1, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1 }, "vracsanscontrat": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1 }, "vrac": { "readable": 1, "writable": 1, "details": 1, "mouvement_coefficient": -1, "vrac": 1, "facturable": 1 }, "bib": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1 }, "bouteille": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 1 }, "consommation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "distillation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "fermagemetayage": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "repli": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "declassement": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "cooperative": { "readable": 1, "writable": 1, "details": 1, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "cession": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "elaboration": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 }, "regularisation": { "readable": 1, "writable": 1, "details": 0, "mouvement_coefficient": -1, "vrac": 0, "facturable": 0 } }, "stocks_fin": { "revendique": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 }, "instance": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 }, "bloque": { "readable": 1, "writable": 0, "details": 0, "mouvement_coefficient": 0, "vrac": 0, "facturable": 0 } } } }}' $DBURL$DBNAME/CONFIGURATION

curl -s -X PUT -d '{
   "_id": "_design/etablissement", "language": "javascript", "views": {"all": {"map": "function(doc) {\n  \tif (doc.type != \"Etablissement\") {\n\n        return;\n    }\n    \n    emit([doc.interpro, doc.statut, doc.famille, doc.id_societe, doc._id, doc.nom, doc.identifiant, doc.cvi, doc.region], [doc.raison_sociale, doc.siege.adresse, doc.siege.commune, doc.siege.code_postal, doc.no_accises, doc.carte_pro, doc.email, doc.telephone, doc.fax, doc.recette_locale.id_douane, doc.recette_locale.nom]);\n    if (doc.cooperative && doc.cooperative != \"0\") {\n\temit([doc.interpro, doc.statut, \"COOPERATIVE\", doc.id_societe, doc._id, doc.nom, doc.identifiant, doc.cvi, doc.region], [doc.raison_sociale, doc.siege.adresse, doc.siege.commune, doc.siege.code_postal, doc.no_accises, doc.carte_pro, doc.email, doc.telephone, doc.fax, doc.recette_locale.id_douane, doc.recette_locale.nom]);\n    }\n}","reduce": "function (keys, values, rereduce) {\n    \n\tif(!rereduce) {\n\t\treturn values.length;\n\t}\n\n\treturn sum(values);\n}\n"},"region": {"map": "function(doc) {\n\n    if (doc.type != \"Etablissement\") {\n        \n        return ;     \n    }     \n    \n    if (doc.cooperative && doc.cooperative != \"0\") {\n        emit([\"COOPERATIVE\", doc.statut, doc.region, doc.siege.commune, doc.siege.code_postal, doc.cvi, doc.nom, doc.identifiant], 1);\n    } else {\n        emit([doc.famille, doc.statut, doc.region, doc.siege.commune, doc.siege.code_postal, doc.cvi, doc.nom, doc.identifiant], 1);\n    }\n}"}}}' $DBURL$DBNAME/_design/etablissement

curl -s -X PUT -d '{ "_id": "_design/vrac", "language": "javascript", "views": { "history": { "map": "function(doc) {\n if ((doc.type != \"Vrac\") || (doc.valide.statut == null)) {\n \n return;\n }\n\n var original = \"OUI\";\n if (doc.attente_original) {\n original = \"NON\"\n }\n \n var prix_variable = \"NON\";\n if (doc.prix_variable) {\n prix_variable = \"OUI\";\n }\n\n var interne = \"NON\";\n if (doc.interne) {\n interne = \"OUI\";\n }\n\n var archive = doc.numero_contrat;\n if (doc.numero_archive) {\n\t archive = doc.numero_archive;\n }\n\n emit([doc._id], [doc.campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve, doc.prix_initial_unitaire_hl, doc.prix_unitaire_hl, prix_variable, interne, original, doc.type_contrat, doc.date_signature, doc.date_campagne, doc.valide.date_saisie, doc.millesime, doc.categorie_vin, doc.domaine, doc.part_variable, doc.cvo_repartition, doc.cvo_nature]);\n}" },"domaines": {"map": "function(doc) {\n  \tif ((doc.type != \"Vrac\") || (doc.valide.statut == null)) {\n    \t\n    \treturn;\n    }\n  \t\n  \tif (doc.domaine) {\n  \t\t\n  \t\temit([doc.vendeur_identifiant, doc.domaine],  1);\n  \t}\n}","reduce": "function (keys, values) {\n \t\n \treturn sum(values);\n}"},       "soussigneidentifiant": {"reduce": "function (keys, values, rereduce) {\n    \n    if(!rereduce) {\n        return values.length;\n    }\n\n    return sum(values);\n}","map": "function(doc) {\n  \tif (doc.type != \"Vrac\")\n    \treturn;\n\n\t campagne = doc.campagne;\n\n    archive = doc.numero_contrat;\n    if (doc.numero_archive) {\n\tarchive = doc.numero_archive;\n    }\n\n    if (doc.mandataire_identifiant)\n\temit([\"STATUT\", doc.mandataire_identifiant, campagne, doc.valide.statut, doc.type_transaction],  [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n  \t\n    emit([\"STATUT\", doc.acheteur_identifiant, campagne, doc.valide.statut, doc.type_transaction], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n  \t\n    emit([\"STATUT\", doc.vendeur_identifiant, campagne, doc.valide.statut, doc.type_transaction], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n  \t\n    if (doc.mandataire_identifiant)\n\temit([\"TYPE\", doc.mandataire_identifiant, campagne, doc.type_transaction],  [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n  \t\n    emit([\"TYPE\", doc.acheteur_identifiant, campagne, doc.type_transaction], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n  \t\n    emit([\"TYPE\", doc.vendeur_identifiant, campagne, doc.type_transaction], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve]);\n    \n    if (doc.mandataire_identifiant)\n\temit([\"SOCIETE\", campagne, doc.mandataire_identifiant, doc.valide.statut],  [campagne, doc.valide.statut, doc._id, doc.numero_contrat, doc.numero_archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve, doc.createur_identifiant, doc.valide.date_signature_vendeur, doc.valide.date_signature_acheteur, doc.valide.date_signature_courtier, doc.bouteilles_quantite, doc.jus_quantite, doc.raisin_quantite, doc.prix_initial_unitaire]);\n  \t\n    emit([\"SOCIETE\", campagne, doc.acheteur_identifiant, doc.valide.statut], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, doc.numero_archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve, doc.createur_identifiant, doc.valide.date_signature_vendeur, doc.valide.date_signature_acheteur, doc.valide.date_signature_courtier, doc.bouteilles_quantite, doc.jus_quantite, doc.raisin_quantite, doc.prix_initial_unitaire]);\n  \t\n    emit([\"SOCIETE\", campagne, doc.vendeur_identifiant, doc.valide.statut], [campagne, doc.valide.statut, doc._id, doc.numero_contrat, doc.numero_archive, doc.acheteur_identifiant, doc.acheteur.nom, doc.vendeur_identifiant, doc.vendeur.nom, doc.mandataire_identifiant,doc.mandataire.nom, doc.type_transaction, doc.produit, doc.produit_libelle, doc.volume_propose, doc.volume_enleve, doc.createur_identifiant, doc.valide.date_signature_vendeur, doc.valide.date_signature_acheteur, doc.valide.date_signature_courtier, doc.bouteilles_quantite, doc.jus_quantite, doc.raisin_quantite, doc.prix_initial_unitaire]);\n\n}"}, "vracSimilaire": {"map": "function(doc) {\n  \tif (doc.type != \"Vrac\") {\n\n \t\treturn;\n \t}\n        if ((doc.valide.statut != \"SOLDE\") && (doc.valide.statut != \"NONSOLDE\")) {\n \t\treturn;\n \t}\n    mandataire = \"\";\n    if (doc.mandataire_identifiant) {\n\tmandataire = doc.mandataire_identifiant;\n    }\n    emit([doc.vendeur_identifiant, doc.acheteur_identifiant, mandataire, doc.type_transaction, doc.produit, doc.volume_propose],[doc.numero_contrat, doc.valide.statut, doc.millesime , doc.volume_propose, doc.numero_archive]);\n}"} } }' $DBURL$DBNAME/_design/vrac
