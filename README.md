# Acerca de los lanzamientos

Puedes crear un lanzamiento para empaquetar software, junto con notas de lanzamiento y enlaces a archivos binarios, para que los usen otras personas.

## Acerca de los lanzamientos

Los lanzamientos son iteraciones de software desplegable que puedes empaquetar y poner a disposición de una audiencia más amplia para su descarga y uso.

Las versiones se basan en [etiquetas de Git](https://git-scm.com/book/en/v2/Git-Basics-Tagging), que marcan un punto específico en el historial del repositorio. Una fecha de etiqueta puede ser diferente a una fecha de lanzamiento ya que ambas pueden crearse en momentos diferentes. Para obtener más información sobre la visualización de las etiquetas existentes, consulta [Visualizar los lanzamientos y etiquetas de tu repositorio](/es/repositories/releasing-projects-on-github/viewing-your-repositorys-releases-and-tags).

Puedes recibir notificaciones cuando se publican nuevos lanzamientos en un repositorio sin recibir notificaciones sobre otras actualizaciones del repositorio. Para más información, consulta [Visualizar tus suscripciones](/es/subscriptions-and-notifications/how-tos/managing-subscriptions-for-activity-on-github/viewing-your-subscriptions).

Cualquiera que tenga acceso de lectura a un repositorio podrá ver y comparar los lanzamientos, pero únicamente aquellos con permisos de escritura en éste podrán administrarlos. Para más información, consulta [Administrar lanzamientos en un repositorio](/es/repositories/releasing-projects-on-github/managing-releases-in-a-repository).

Puedes crear notas de lanzamiento manualmente mientras administras un lanzamiento. Como alternativa, puedes generar notas de lanzamiento automáticamente desde una plantilla predeterminada o personalizar tu propia plantilla de notas de lanzamiento. Para más información, consulta [Notas de lanzamiento generadas automáticamente](/es/repositories/releasing-projects-on-github/automatically-generated-release-notes).

Al ver los detalles de una versión, la fecha de creación de cada activo de la versión se muestra junto al mismo.

GitHub incluirá automáticamente vínculos para descargar un archivo ZIP y un tarball que contenga el contenido del repositorio en el momento de la creación de la etiqueta.

Los usuarios con permisos de administrador en un repositorio pueden elegir si los objetos Almacenamiento de archivos de gran tamaño de Git (Git LFS) se incluyen en los archivos ZIP y tarballs que GitHub crea para cada versión. Para más información, consulta [Administrar los objetos de LFS de Git en los archivos de tu repositorio](/es/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/managing-git-lfs-objects-in-archives-of-your-repository).

Si un lanzamiento arregla una vulnerabilidad de seguridad, deberás publicar una asesoría de seguridad en tu repositorio.
GitHub revisa cada aviso de seguridad publicado y puede usarlo para enviarlo Dependabot alerts a repositorios afectados. Para más información, consulta [Asesorías de seguridad de repositorio](/es/code-security/concepts/vulnerability-reporting-and-management/repository-security-advisories).

Puede ver la pestaña **Dependientes** del gráfico de dependencias a fin de ver qué repositorios y paquetes dependen del código en el repositorio y, por tanto, podrían verse afectados por una versión nueva. Para más información, consulta [Gráfica de dependencias](/es/code-security/concepts/supply-chain-security/dependency-graph).

También puedes usar la API de releases para recopilar información, como la cantidad de veces que las personas descargan un recurso de lanzamiento. Para más información, consulta [Puntos de conexión de la API REST para versiones y activos de lanzamiento](/es/rest/releases).

## Cuotas de ancho de banda y de almacenamiento

Se pueden asociar hasta 1 000 activos de lanzamiento a un único lanzamiento. Cada archivo incluido en una versión debe estar en 2 GiB. No hay un límite para el tamaño total de un lanzamiento, ni para el uso de ancho de banda.
