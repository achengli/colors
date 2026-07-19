#!/bin/bash
# setup-ollama-remote.sh
# Configura Ollama en macOS para conectarse a un servidor remoto (Mini PC)
#
# Uso:
#   chmod +x setup-ollama-remote.sh
#   ./setup-ollama-remote.sh
#
# Qué hace:
#   1. Instala Ollama si no está presente
#   2. Configura ~/.ollama/config.json con HOST = 192.168.0.27:11434
#      (la app de escritorio lee esto para saber a qué servidor conectarse)
#   3. Añade OLLAMA_HOST=192.168.0.27:11434 al .zshrc sin export
#      (disponible en terminal pero sin contaminar apps GUI)
#   4. launchctl setenv OLLAMA_HOST=192.168.0.27:11434
#      (para que Ollama Desktop herede la variable al abrirlo)
#
# Por qué no usar "export OLLAMA_HOST" en el shell:
#   Ollama Desktop inicia un servidor local (ollama serve) que hereda
#   OLLAMA_HOST e intenta bindear a esa IP. Si la IP no es local
#   (ej: 192.168.0.27), el servidor falla con "bind: can't assign
#   requested address". La UI funciona igual porque se conecta
#   directamente al remoto, pero los logs se llenan de errores.
#   Con "sin export", el servidor usa 127.0.0.1:11434 por defecto
#   y funciona correctamente.
#
# Para deshacer:
#   - Eliminar OLLAMA_HOST de ~/.zshrc
#   - launchctl unsetenv OLLAMA_HOST
#   - Restaurar ~/.ollama/config.json

set -e

REMOTE_HOST="192.168.0.27"
REMOTE_PORT="11434"

echo "=== Configuración de Ollama para conectar a Mini PC ==="
echo "Servidor remoto: $REMOTE_HOST:$REMOTE_PORT"
echo ""

# 1. Verificar/instalar Ollama
if ! command -v ollama &> /dev/null; then
    echo "[1/4] Instalando Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "[1/4] Ollama ya instalado ($(ollama --version))"
fi

# 2. Configurar ~/.ollama/config.json
echo "[2/4] Configurando servidor remoto en ~/.ollama/config.json..."
mkdir -p ~/.ollama
cat > ~/.ollama/config.json << EOF
{
  "HOST": "$REMOTE_HOST:$REMOTE_PORT"
}
EOF
echo "  -> ~/.ollama/config.json actualizado"

# 3. Configurar shell (OLLAMA_HOST sin export)
SHELL_RC="$HOME/.zshrc"
if [ ! -f "$SHELL_RC" ]; then
    SHELL_RC="$HOME/.bash_profile"
fi

echo "[3/4] Configurando variable de entorno en $SHELL_RC..."
if grep -q "OLLAMA_HOST" "$SHELL_RC" 2>/dev/null; then
    # Reemplazar cualquier línea con OLLAMA_HOST
    sed -i '' '/OLLAMA_HOST/d' "$SHELL_RC"
fi
echo "OLLAMA_HOST=$REMOTE_HOST:$REMOTE_PORT" >> "$SHELL_RC"
echo "  -> Línea añadida (sin export, solo para terminal)"

# 4. Limpiar launchctl y recomendar reinicio
echo "[4/4] Limpiando entorno launchctl..."
launchctl unsetenv OLLAMA_HOST 2>/dev/null || true
launchctl setenv OLLAMA_HOST "$REMOTE_HOST:$REMOTE_PORT"

echo ""
echo "=== Configuración completada ==="
echo ""
echo "Pasos manuales:"
echo "  1. Cierra y vuelve a abrir Ollama Desktop"
echo "  2. Si no ves los modelos, ve a Ollama > Settings > Advanced"
echo "     y verifica que el host sea $REMOTE_HOST:$REMOTE_PORT"
echo ""
echo "Para probar desde terminal:"
echo "  ollama list"
echo ""
echo "Para deshacer cambios:"
echo "  - Eliminar OLLAMA_HOST de $SHELL_RC"
echo "  - launchctl unsetenv OLLAMA_HOST"
echo "  - Restaurar ~/.ollama/config.json"
