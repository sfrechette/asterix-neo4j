// Create indexes for faster lookup
CREATE INDEX ON :Album(album);
CREATE INDEX ON :Personnage(personnage);
CREATE INDEX ON :Nationalite(nationalite);

// Create constraints
CREATE CONSTRAINT ON (a:Album) ASSERT a.albumId IS UNIQUE;
CREATE CONSTRAINT ON (p:Personnage) ASSERT p.personnageId IS UNIQUE;
CREATE CONSTRAINT ON (n:Nationalite) ASSERT n.nationaliteId IS UNIQUE;
CREATE CONSTRAINT ON (e:Editeur) ASSERT e.editeurId IS UNIQUE;
CREATE CONSTRAINT ON (d:Dessinateur) ASSERT d.dessinateurId IS UNIQUE;
CREATE CONSTRAINT ON (s:Scenariste) ASSERT s.scenaristeId IS UNIQUE;
CREATE CONSTRAINT ON (pt:PersonnageType) ASSERT pt.personnageTypeId IS UNIQUE;

// Create albums
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/albums.csv" as row
CREATE (:Album {album: row.Album, albumId: row.AlbumID, premiereEdition: row.PremiereEdition});

// Create dessinateurs
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/dessinateurs.csv" as row
CREATE (:Dessinateur {dessinateur: row.Dessinateur, dessinateurId: row.DessinateurID});

// Create editeurs
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/editeurs.csv" as row
CREATE (:Editeur {editeur: row.Editeur, editeurId: row.EditeurID});

// Create scenaristes
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/scenaristes.csv" as row
CREATE (:Scenariste {scenariste: row.Scenariste, scenaristeId: row.ScenaristeID});

// Create nationalite
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/nationalite.csv" as row
CREATE (:Nationalite {nationalite: row.Nationalite, nationaliteId: row.NationaliteID});

// Create personnagetype
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/personnagetype.csv" as row
CREATE (:PersonnageType {personnageType: row.PersonnageType, personnageTypeId: row.PersonnageTypeID});

// Create personnages
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/personnages.csv" as row
CREATE (:Personnage {personnage: row.Personnage, personnageId: row.PersonnageID, occupation: row.Occupation});

// Create relationships: Album to Dessinateur
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/albums.csv" AS row
MATCH (album:Album {albumId: row.AlbumID})
MATCH (dessinateur:Dessinateur {dessinateurId: row.DessinateurID})
MERGE (dessinateur)-[:A_DESSINE]->(album);

// Create relationships: Album to Scenariste
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/albums.csv" AS row
MATCH (album:Album {albumId: row.AlbumID})
MATCH (scenariste:Scenariste {scenaristeId: row.ScenaristeID})
MERGE (scenariste)-[:A_ECRIT]->(album);

// Create relationships: Album to Editeur
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/albums.csv" AS row
MATCH (album:Album {albumId: row.AlbumID})
MATCH (editeur:Editeur {editeurId: row.EditeurID})
MERGE (editeur)-[:A_PUBLIE]->(album);

// Create relationships: Personnage to Nationalite
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/personnages.csv" AS row
MATCH (personnage:Personnage {personnageId: row.PersonnageID})
MATCH (nationalite:Nationalite {nationaliteId: row.NationaliteID})
MERGE (personnage)-[:NATIONALITE]->(nationalite);

// Create relationships: Personnage to PersonnageType
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/personnages.csv" AS row
MATCH (personnage:Personnage {personnageId: row.PersonnageID})
MATCH (personnagetype:PersonnageType {personnageTypeId: row.PersonnageTypeID})
MERGE (personnage)-[:PERSONNAGE_TYPE]->(personnagetype);

// Create relationships: Personnage to Album
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/personnagealbum.csv" AS row
MATCH (personnage:Personnage {personnageId: row.PersonnageID})
MATCH (album:Album {albumId: row.AlbumID})
MERGE (personnage)-[:APPARAIT_DANS]->(album);

// Create relationships: Personnage to Personnage (Compagnon d'aventure)
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/Users/stephanefrechette/Projects/asterix-neo4j/data/compagnonaventure.csv" AS row
MATCH (personnage:Personnage {personnageId: row.PersonnageID})
MATCH (compagnon:Personnage {personnageId: row.CompagnonID})
MERGE (personnage)-[:COMPAGNON_AVENTURE]->(compagnon);
