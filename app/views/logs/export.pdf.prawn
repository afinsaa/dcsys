

prawn_document do |pdf|
  pdf.font "Helvetica"
  # pdf.font.size = 13
  pdf.text 'Current Products are:'
  pdf.move_down 20
  # pdf.table [['d']]
  # pdf.table @logs.collect{|p| [p.student.sid,p.student.name, p.tawaklna_s]}
  pdf.table(@logs.collect{|p| [p.student.sid,p.student.name, p.tawaklna_s, p.created_at.to_s]}, header: true)
end