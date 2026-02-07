# 🧬 RNA-seq Course 2025 - Setup per Studenti

## 📋 Prerequisiti (15 minuti)

### 1. Installare Docker Desktop
- **Windows**: [Download Docker Desktop per Windows](https://www.docker.com/products/docker-desktop)
  - ⚠️ Assicurati che WSL2 sia abilitato (Docker lo chiederà durante l'installazione)
- **macOS**: [Download Docker Desktop per Mac](https://www.docker.com/products/docker-desktop)
  - Scegli la versione corretta: Intel Chip o Apple Silicon (M1/M2/M3)

### 2. Installare Visual Studio Code
- [Download VS Code](https://code.visualstudio.com/)

### 3. Installare l'estensione Dev Containers
1. Apri VS Code
2. Clicca sull'icona Extensions (quadratini sulla sinistra)
3. Cerca: **Dev Containers**
4. Clicca su **Install**

## 🚀 Avvio Rapido (5 minuti)

### Passo 1: Scarica il materiale del corso
```bash
git clone https://github.com/YOUR_REPO/2025_RNASeq_v2.git
cd 2025_RNASeq_v2
```

### Passo 2: Apri in VS Code
```bash
code .
```

### Passo 3: Apri nel Container
1. VS Code mostrerà un popup: **"Reopen in Container"** → Clicca
   
   **OPPURE**
   
2. Premi `Ctrl+Shift+P` (Windows) o `Cmd+Shift+P` (Mac)
3. Cerca: **"Dev Containers: Reopen in Container"**
4. Premi Invio

### Passo 4: Attendi il Download
- Prima volta: ~3-5 minuti (download ~3GB)
- Volte successive: ~30 secondi

✅ **Fatto!** Tutti i tool sono già installati.

## 🧪 Verifica Installazione

Apri il terminale in VS Code (`Ctrl+\`` or Terminal → New Terminal) ed esegui:

```bash
# Verifica strumenti bioinformatici
salmon --version
fastqc --version
multiqc --version
quarto --version

# Verifica pacchetti R
R -e "library(DESeq2); library(tximport); cat('✅ OK\n')"
```

Dovresti vedere le versioni dei programmi senza errori.

## 📚 Inizia il Corso

```bash
cd RNASeq_Course_2025
quarto preview
```

Il browser si aprirà automaticamente con il materiale del corso.

## ❓ Problemi Comuni

### Docker non parte
- **Windows**: Verifica che Docker Desktop sia in esecuzione (icona nella system tray)
- **Mac**: Verifica che Docker Desktop sia in esecuzione (icona nella menu bar)
- **Linux**: Esegui `sudo systemctl start docker`

### Download lento
È normale la prima volta. Il container è ~3GB.
- Assicurati di avere buona connessione Internet
- Se interrotto, riproverà automaticamente

### Errore "Cannot connect to Docker daemon"
1. Apri Docker Desktop
2. Attendi che dica "Docker is running"
3. Riprova in VS Code

### Windows: Errore WSL2
1. Apri PowerShell come Amministratore
2. Esegui: `wsl --install`
3. Riavvia il computer
4. Riavvia Docker Desktop

### Spazio su disco insufficiente
- Servono almeno **10GB liberi**
- Windows: Libera spazio su `C:\`
- Mac: Libera spazio sul disco principale

## 💡 Consigli

- **Non chiudere Docker Desktop** durante l'uso
- **Il container salva i tuoi file**: modifiche ai file del corso sono persistenti
- **Riavvio veloce**: la prossima volta apri semplicemente il progetto in VS Code

## 🆘 Supporto

Se hai problemi:
1. Verifica di aver seguito tutti i passaggi
2. Riavvia Docker Desktop
3. Riavvia VS Code
4. Contatta il docente con screenshot dell'errore

---

🎓 **Buon corso!**
