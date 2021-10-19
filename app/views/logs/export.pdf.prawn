

prawn_document do |pdf|
  pdf.font Rails.root.join('app/assets/fonts/ArialUnicodeMS.ttf')
  # pdf.font.size = 13
  pdf.text "#{t('portal.logs.export.title').fix_arabic_glyphs}:"
  pdf.text @search_val
  pdf.move_down 20
  # pdf.table [['d']]
  # pdf.table @logs.collect{|p| [p.student.sid,p.student.name, p.tawaklna_s]}
  pdf.table(@logs.collect{|p| [p.student.sid,p.student.name.fix_arabic_glyphs, p.tawaklna_s.fix_arabic_glyphs, p.created_at.to_s]}, header: true)
end