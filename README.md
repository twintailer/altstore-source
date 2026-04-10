# AltStore Source

Auto-generated AltStore Classic Source with 2 apps.

## Apps

| App | Bundle ID | Version | Size |
|-----|-----------|---------|------|
| YouTube | com.google.ios.youtube | 21.14.4 | 120.8 MB |
| Stremio | com.stremio.ios | 1.3.6 | 75.7 MB |

## Setup

### 1. URLs anpassen

In `apps.json` alle `{{DOWNLOAD_BASE_URL}}` ersetzen mit deiner tatsachlichen URL, z.B.:

- GitHub Pages: `https://username.github.io/altstore-source`
- Eigener Server: `https://example.com/apps`

### 2. Dateien hosten

Die IPA-Dateien und Icons muessen unter der gleichen Base URL erreichbar sein:

```
https://your-url/
├── apps.json
├── icons/
│   ├── com.google.ios.youtube.png
│   └── com.stremio.ios.png
├── 21.14.4_YouTubePlus_5.2b4.ipa
└── stremio_iOS (1).ipa
```

### 3. GitHub Pages (optional)

```bash
chmod +x deploy.sh
./deploy.sh https://github.com/username/altstore-source.git
```

Das Script ersetzt automatisch die Platzhalter, kopiert die IPAs und pusht zu GitHub Pages.

### 4. In AltStore hinzufuegen

1. AltStore oeffnen > Sources > +
2. Source URL eingeben: `https://your-url/apps.json`
3. Apps installieren
