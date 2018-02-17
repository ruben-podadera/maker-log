require 'yaml'

if ARGV.length == 0
  puts "usage: project-graphviz project_uid"
  exit 1
end

$project_uid = ARGV[0]

projects = Hash.new

files = Dir["_tasks/"+$project_uid+"/*.markdown"]
files.each do |file|
  task = YAML.load_file(file)
  puid = task['project_uid']
  if puid != $project_uid
    next
  end

  if !projects.key?(puid)
    projects[puid] = Hash.new
    projects[puid]['tasks'] = Array.new
    projects[puid]['uid'] = puid
  end

  projects[puid]['tasks'].push(task)
end

$color1="#000000"
#$color2="#b5e853"
$color2="#eeeeee"

def renderNode3(task)
  title=task['title']
  title = title.gsub(' ', '<br/>')

  color1 = $color1
  color2 = $color2

  if task['completed']
    color1 = $color2
    color2 = $color1
  end

  bgcolor=color1
  if color1 == $color1
    bgcolor = "#00000000"
  end

  ret = "<
  <table bgcolor=\""+bgcolor+"\" border='1' color=\""+color2+"\">
  <tr>
    <td border='0' cellpadding='5'><font color=\""+color2+"\">"+title+"</font></td>
    <td border='0'>"
    if task['parts'] != nil
      ret += "<table border='0'>"
      task['parts'].each do |name, done|
        # puts done
        if done == task['completed']
            ret += "<tr><td border='1'></td></tr>"
        else
            ret += "<tr><td border='1' bgcolor=\""+color2+"\"></td></tr>"
        end
      end
      ret +="</table>"
    end
    ret +="
    </td>
  </tr>
  </table>>"
  return ret
end


projects.each do |puid, project|
  puts "digraph G {
    node [shape=plaintext]
    graph [fontname = \"helvetica\", bgcolor=\"#00000000\"];
    node [fontname = \"helvetica\"];
    edge [fontname = \"helvetica\", color=\""+$color2+"\"];"

  # declare all nodes
  project['tasks'].each do |task|
    url = "/tasks/" + project['uid'] + "/" + task['uid'] + ".html"
    puts "   %s_%s [label=%s, href=\"%s\"]" % [
      project['uid'],
      task['uid'],
      renderNode3(task),
      url
    ]
  end

  # declare relation
  project['tasks'].each do |task|
    if task['need_tasks'] != nil
      task['need_tasks'].each do |needed_task|
        puts "   %s_%s -> %s_%s" % [project['uid'], needed_task, project['uid'], task['uid']]
      end
    end
  end
  puts "}"
end
