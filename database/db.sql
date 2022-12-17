-- Supprimer les tables si elles existent
DROP TABLE IF EXISTS statuts CASCADE;
DROP TABLE IF EXISTS prestataires CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS architectes CASCADE;
DROP TABLE IF EXISTS projets CASCADE;
DROP TABLE IF EXISTS parcelles CASCADE;
DROP TABLE IF EXISTS phases CASCADE;
DROP TABLE IF EXISTS taches CASCADE;
DROP TABLE IF EXISTS tags CASCADE;
DROP TABLE IF EXISTS tags_projets CASCADE;
DROP TABLE IF EXISTS documents CASCADE;

-- Créer la table des statuts
CREATE TABLE statuts (
  id INTEGER PRIMARY KEY,
  label VARCHAR(255) NOT NULL
);

-- Créer la table des prestataires
CREATE TABLE prestataires (
  id serial PRIMARY KEY,
  assurance BYTEA NOT NULL,
  nom VARCHAR(255) NOT NULL,
  nom_contact VARCHAR(255) NOT NULL,
  adresse VARCHAR(255) NOT NULL,
  telephone INTEGER NOT NULL,
  email VARCHAR(255) NOT NULL,
  siret INTEGER NOT NULL
);

-- Créer la table des architectes
CREATE TABLE architectes (
  id serial PRIMARY KEY,
  numero_national INTEGER NOT NULL,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  mot_de_passe VARCHAR(255) NOT NULL,
  telephone INTEGER NOT NULL
);

-- Créer la table des clients
CREATE TABLE clients (
  id serial PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  nom_contact VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  adresse VARCHAR(255) NOT NULL,
  telephone INTEGER NOT NULL,
  notes TEXT,
  architecte_id INTEGER REFERENCES architectes(id)
);

-- Créer la table des projets
CREATE TABLE projets (
  id serial PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  surface_fonciere INTEGER NOT NULL,
  surface_indicative INTEGER NOT NULL,
  ville VARCHAR(255) NOT NULL,
  adresse VARCHAR(255) NOT NULL,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  description TEXT,
  statut_id INTEGER REFERENCES statuts(id),
  client_id INTEGER REFERENCES clients(id),
  architecte_id INTEGER REFERENCES architectes(id)
);

-- Créer la table des parcelles
CREATE TABLE parcelles (
  section VARCHAR(255),
  numero INTEGER,
  surface INTEGER NOT NULL,
  projet_id INTEGER REFERENCES projets(id),
  PRIMARY KEY (section, numero)
);

-- Créer la table des phases
CREATE TABLE phases (
  id serial PRIMARY KEY,
  code VARCHAR(255) NOT NULL,
  label VARCHAR(255) NOT NULL,
  honoraires INTEGER NOT NULL,
  description TEXT NOT NULL,
  projet_id INTEGER REFERENCES projets(id)
);

-- Créer la table des tâches
CREATE TABLE taches (
  id serial PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  annexe BYTEA NOT NULL,
  description TEXT NOT NULL,
  date_echeance DATE NOT NULL,
  phase_id INTEGER REFERENCES phases(id),
  prestataire_id INTEGER REFERENCES prestataires(id),
  realise_par_architecte BOOLEAN NOT NULL DEFAULT FALSE,
  architecte_id INTEGER REFERENCES architectes(id)
);

-- Créer la table des tags
CREATE TABLE tags (
  id serial PRIMARY KEY,
  label VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL,
  architecte_id INTEGER REFERENCES architectes(id)
);

-- Créer la table de relation entre tags et projets
CREATE TABLE tags_projets (
  id serial PRIMARY KEY,
  tag_id INTEGER REFERENCES tags(id),
  projet_id INTEGER REFERENCES projets(id)
);

-- Créer la table des documents
CREATE TABLE documents (
  id serial PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL,
  fichier BYTEA NOT NULL,
  projet_id INTEGER REFERENCES projets(id)
);

-- Contrainte
ALTER TABLE taches
ADD CONSTRAINT check_realise_par_architecte_and_ids
CHECK (
    (realise_par_architecte = TRUE AND prestataire_id IS NULL AND architecte_id IS NOT NULL)
    OR (realise_par_architecte = FALSE AND prestataire_id IS NOT NULL AND architecte_id IS NULL)
);