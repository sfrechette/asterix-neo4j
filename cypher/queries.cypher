// Liste des personnages par album
MATCH (p:Personnage)-->(a:Album)
RETURN a.album as Album, collect(distinct p.personnage) as Personnage, a.premiereEdition as PremiereEdition
ORDER BY a.premiereEdition ASC;

// Liste des personnages par nationalite + Nombre
MATCH (p:Personnage)-->(n:Nationalite)
RETURN n.nationalite as Nationalite, collect(distinct p.personnage) as Personnage, count(p) as Nombre
ORDER BY count(p) DESC;

// Liste des personnages par personnage type + Nombre
MATCH (p:Personnage)-->(t:PersonnageType)
RETURN t.personnageType as PersonnageType, collect(distinct p.personnage) as Personnage, count(p) as Nombre
ORDER BY count(p) DESC;

// Nombre de personnages par album
MATCH (a)<-[:APPARAIT_DANS]-(p)
WITH a, count(p.personnage) as NombrePersonnage
ORDER BY NombrePersonnage DESC
RETURN a.album as Album, NombrePersonnage;

// Liste des albums ou Cléopâtre apparaît
MATCH (a)<-[:APPARAIT_DANS]-(c)
WHERE c.personnage= 'Cléopâtre'
RETURN a.album as Album, a.premiereEdition as PremiereEdition
ORDER BY a.premiereEdition ASC;

// Liste des albums ou Ordralfabétix apparaît
MATCH (a)<-[:APPARAIT_DANS]-(c)
WHERE c.personnage = 'Ordralfabétix'
RETURN a.album as Album, a.premiereEdition as PremiereEdition
ORDER BY a.premiereEdition ASC;

// Dans quels albums Panoramix n'apparait-il pas?
MATCH (a:Album), (panoramix {personnage: 'Panoramix'})
WHERE NOT (a)<--(panoramix)
RETURN a.album as Album;

// Liste des compagnons d'aventure de Batdaf
MATCH (b)-[:COMPAGNON_AVENTURE]-(d)
WHERE d.personnage= 'Batdaf'
RETURN distinct(b.personnage) as CompagnonAventure

// Graph compagnons d'aventure et type de personnage de Panoramix
MATCH ()-[t:PERSONNAGE_TYPE]-()-[r:COMPAGNON_AVENTURE]-(p:Personnage {personnage: 'Panoramix'})
RETURN r, t

// Graph trouver les amis (compagnons d'aventure) d'Astérix qui ont des amis de nationalité romaine (shortest path)
MATCH (asterix {personnage:"Astérix"}), (perso)-[:NATIONALITE]->(n:Nationalite {nationalite:"Romain"}),
  p = shortestPath( (asterix)-[:COMPAGNON_AVENTURE*..4]-(perso))
RETURN p,perso
