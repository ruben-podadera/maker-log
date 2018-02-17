#!/bin/sh

for project in `ls _projects`
do
  puid=`echo $project | cut -d. -f1`
  echo "Duming graph and map file for project '$puid'"

  ruby ./scripts/project-graphviz.rb $puid > assets/graphviz/$puid.dot
  dot -Tsvg assets/graphviz/$puid.dot > assets/graphviz/$puid.svg
  dot -Tcmapx assets/graphviz/$puid.dot | sed 's/title="&lt;TABLE&gt;"//' > _includes/graphviz/$puid.map
  rm assets/graphviz/$puid.dot
done
