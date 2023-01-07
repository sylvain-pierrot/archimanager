-- Insert some statuts
INSERT INTO statuts (id, label)
VALUES (1, 'En cours'), (2, 'Terminé'), (3, 'Annulé'), (4, 'Échéance passée');

-- Insert some missions
INSERT INTO missions (id, label)
VALUES (1, 'Complète'), (2, 'Partielle');

-- Insert some désignations
INSERT INTO designations (id, label)
VALUES (1, 'Usage personnel'), (2, 'Autre usage');

-- Insert some roles
INSERT INTO roles (id, label)
VALUES (1, 'admin'), (2, 'user');

-- Insert admin
INSERT INTO architectes (numero_national, nom, prenom, email, mot_de_passe, telephone, role_id)
VALUES (123, 'PIERROT', 'SYLVAIN', 'pierrot.sylvain14@gmail.com', '$2b$10$FXXdh95/WbWFdJycGkyDGu5E5RZBoUS.jebnXm08bvvZrl4aPo.GO', '07-78-55-61-36', 1);
