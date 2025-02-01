#!/bin/bash

echo "Vérification du service Ollama..."

# Fonction pour tester la connexion avec retry
test_connection() {
    local max_attempts=5
    local attempt=1
    local wait_time=10  # Augmenté à 10 secondes

    while [ $attempt -le $max_attempts ]; do
        echo "Tentative de connexion $attempt/$max_attempts..."
        
        # Test avec une requête simple
        response=$(curl -s -w "%{http_code}" -H "Content-Type: application/json" --max-time 10 http://localhost:11434/api/generate -d '{
            "model": "deepseek-coder:1.3b",
            "prompt": "test",
            "stream": false
        }' 2>/dev/null)
        
        http_code=${response: -3}
        if [ "$http_code" = "200" ]; then
            echo "Connexion établie avec succès"
            return 0
        fi
        
        echo "Attente de $wait_time secondes avant la prochaine tentative..."
        sleep $wait_time
        attempt=$((attempt + 1))
    done

    return 1
}

# Test de connexion avec retry
if ! test_connection; then
    echo "ERREUR: Le service Ollama n'est pas disponible après plusieurs tentatives"
    echo "Vérification du conteneur Docker..."
    docker ps | grep ollama || echo "Le conteneur n'est pas en cours d'exécution"
    echo "Logs du conteneur:"
    docker logs $(docker ps -q --filter name=ollama) | tail -n 20
    echo "Vérification du port 11434..."
    sudo lsof -i :11434 || echo "Aucun processus n'écoute sur le port 11434"
    exit 1
fi

# Vérifier si le modèle est chargé
if ! curl -s http://localhost:11434/api/tags | grep -q "deepseek-r1:1.5b"; then
    echo "ERREUR: Le modèle deepseek-r1:1.5b n'est pas chargé"
    exit 1
fi

# Envoyer la requête finale avec stream désactivé
curl -H "Content-Type: application/json" http://localhost:11434/api/generate -d '{
  "model": "deepseek-r1:1.5b",
  "prompt": "Write a hello world in Python",
  "stream": false
}'

echo "Génération de code terminée"