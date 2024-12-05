# StarkNet Reward Contract 📜

## Description  
Ce projet implémente un smart contract sur StarkNet pour gérer un système de récompenses par points. Les fonctionnalités incluent :  
- Ajout de points à un utilisateur.  
- Échange de points entre utilisateurs.  
- Consultation du solde de points d'un utilisateur.  

Le smart contract utilise **Cairo** et l'interface **StarkNet** pour garantir la sécurité et l'efficacité des transactions.

---

## Fonctionnalités 📋  

### **1. Ajouter des points**  
Ajoute un certain nombre de points à l'utilisateur qui appelle la fonction.  
- **Restrictions** : Les points doivent être compris entre 1 et 50 inclus.  
- **Événement** : Un événement `PointAdded` est émis après un ajout réussi.  

### **2. Échanger des points**  
Transfère des points d'un utilisateur à un autre.  
- **Conditions** : L'utilisateur source doit avoir suffisamment de points pour l'échange.  
- **Événement** : Un événement `PointReDeen` est émis après un échange réussi.  

### **3. Vérifier le solde**  
Retourne le solde actuel de points pour un utilisateur donné.  

---

## Prérequis 🛠️  

1. **StarkNet CLI** : Assurez-vous que StarkNet est installé et configuré.  
2. **Cairo Compiler** : Installez le compilateur Cairo pour construire le contrat.  
   ```bash
   curl -L https://github.com/starkware-libs/cairo/releases/latest/download/cairo-ubuntu-20.04.tar.gz | tar -xz
3. **Cairo Compiler** : Scarb : Installez Scarb, l’environnement de gestion de projet Cairo.  
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh

## Installation 🚀
1. **Cairo Compiler** : Scarb : Installez Scarb, l’environnement de gestion de projet Cairo.  
   ```bash
   git clone https://github.com/<votre-utilisateur>/reward-contract.git
   cd reward-contract
   ```

2. **Cairo Compiler** : Compilez le contrat avec Scarb :.  
   ```bash
   scarb build
   ```

3. **Cairo Compiler** : Déployez le contrat sur le réseau StarkNet :.  
   ```bash
   starknet deploy --compiled_contract target/release/reward_contract.json
   ```