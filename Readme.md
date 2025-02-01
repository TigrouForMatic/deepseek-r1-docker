# Ollama avec DeepSeek Coder

Ce dépôt contient les scripts nécessaires pour exécuter le modèle DeepSeek Coder via Ollama.

## Prérequis

- Docker installé sur votre machine
- Curl installé pour les tests d'API
- Au moins 8GB de RAM disponible

## Structure du projet

- `start.sh` : Script de démarrage du conteneur Ollama et chargement du modèle
- `test_command.sh` : Script de test pour vérifier le bon fonctionnement du service
- `version.sh` : Script pour vérifier la version d'Ollama

## Installation et démarrage

1. Clonez ce dépôt :

```bash
git clone https://github.com/votre-username/ollama-deepseek.git
cd ollama-deepseek
```

2. Construisez l'image Docker :

```bash
docker build -t ollama-deepseek .
```

3. Démarrez le service :

```bash
./run.sh
```

## Utilisation

Une fois le service démarré, vous pouvez tester son fonctionnement avec :

```bash
./test_command.sh
```


Le service sera accessible sur `http://localhost:11434`

## Fonctionnalités

- Support automatique du GPU si disponible
- Gestion automatique des dépendances
- Nettoyage des processus existants
- Vérification de l'état du service
- Téléchargement automatique du modèle DeepSeek Coder (actuellement seule la version 1.3b est disponible)

## API

Ce projet utilise l'[API officielle d'Ollama](https://github.com/ollama/ollama/blob/main/docs/api.md#list-local-models) pour interagir avec les modèles. Consultez la documentation de l'API pour plus de détails sur les endpoints disponibles.

## Dépannage

Si vous rencontrez des problèmes :

1. Vérifiez les logs du conteneur :

```bash
docker logs ollama
```


2. Assurez-vous que le port 11434 est libre :

```bash
sudo lsof -i :11434
```

3. Si le service ne démarre pas, vérifiez les permissions :

```bash
chmod +x start.sh
chmod +x test_command.sh
chmod +x version.sh
```


4. Redémarrez le service :

```bash
./run.sh
```


## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou une pull request.

## Licence

MIT