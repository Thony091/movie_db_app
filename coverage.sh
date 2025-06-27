#!/bin/sh
# -----------------------------------------------------------
# Script para generar el reporte de cobertura de tests
# y abrirlo en el navegador.
# -----------------------------------------------------------

# Imprime un mensaje para saber que empezó
echo "🚀 Generando reporte de cobertura..."

# 1. Ejecutar tests y generar lcov.info
# El comando fallará si los tests fallan, deteniendo el script.
flutter test --coverage

# 2. Filtrar archivos que no queremos en el reporte
#    - Archivos generados (.g.dart)
#    - Archivos de internacionalización (l10n)
#    - Archivos de exportación (barrels) o el main.
echo "🧹 Limpiando el reporte de cobertura..."
lcov --remove coverage/lcov.info \
  'lib/main.dart' \
  'lib/**/*.g.dart' \
  'lib/generated/*' \
  -o coverage/lcov_cleaned.info

# 3. Generar el reporte HTML desde el archivo limpio
echo "📄 Generando reporte HTML..."
genhtml coverage/lcov_cleaned.info -o coverage/html

# 4. Abrir el reporte en el navegador (para macOS)
# Si usas Linux, cambia 'open' por 'xdg-open'
# Si usas Windows/WSL, puedes usar 'explorer.exe'
echo "✅ ¡Reporte generado! Abriendo en el navegador..."

# Descomenta la línea correspondiente a tu sistema operativo
open coverage/html/index.html      # Para macOS
# xdg-open coverage/html/index.html  # Para Linux

echo "✨ ¡Listo!"