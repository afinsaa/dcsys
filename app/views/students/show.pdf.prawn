

prawn_document do |pdf|
  pdf.font Rails.root.join('app/assets/fonts/ArialUnicodeMS.ttf')
  # pdf.font Rails.root.join('app/assets/fonts/GE_SS_Unique_Light.otf')

  logoData = [
    
    [
       {:image => Rails.root.join('app/assets/images', "7_logo_c.png"), :scale => 0.025, :position => :center}
    ],
    [
      ("- منصة حصين - #{current_user.school.name}").fix_arabic_glyphs
    ]
  ]
  # t2 = pdf.make_table(logoData, :cell_style => {:padding => [20, 20, 20, 20], :borders => [ ] } , :position => :center)

  pdf.table(logoData, :cell_style => {:padding => [20, 20, 20, 20],  :borders => [ ] })
  

  # pdf.font.size = 13
  # pdf.text ("منصة حصين - #{current_user.school.name}").fix_arabic_glyphs, :position => :center
  # pdf.font "Helvetica"
  pdf.move_down 20
  # pdf.table [['d']]
  # pdf.table @logs.collect{|p| [p.student.sid,p.student.name, p.status]}
  studArray = []
  rowCounter = 0
  s = @student
    # require 'rqrcode'
    
    # qrcode = RQRCode::QRCode.new(s.sid)

    # # NOTE: showing with default options specified explicitly
    # png = qrcode.as_png(
    #   bit_depth: 1,
    #   border_modules: 4,
    #   color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    #   color: "black",
    #   file: nil,
    #   fill: "white",
    #   module_px_size: 6,
    #   resize_exactly_to: false,
    #   resize_gte_to: false,
    #   size: 120
    # )
    fUrl = ""
    File.open(Rails.root.join('app/assets/images', 'tmp', "tmpqr#{current_user.id}.png"), 'wb') do |f|
      f.write(s.qrimage.download)
      fUrl = f.path
    end

    nameCell = pdf.make_cell(content: s.name.fix_arabic_glyphs, borders: [], size: 10, :text_color => "000000", padding: [0,0,0,0], font: Rails.root.join('app/assets/fonts/ArialUnicodeMS.ttf'))
    
    
    sidCell = pdf.make_cell(content: s.sid, borders: [], size: 10, :text_color => "000000", padding: [0,0,0,0], font: 'Helvetica')
    

    sCard = [
      [
        sidCell
       
      ],
      [
         {:image => fUrl, width: 50, :position => :center}
      ],
      [
        nameCell
      ]
    ]
    newS = pdf.make_table(sCard, :cell_style => {:padding => [20, 20, 20, 20], width: 170, :borders => [ ] } , :position => :center)
    
    studArray.append([newS])
  
  pdf.table(studArray) do |t|
    t.cells.border_width = 1
    t.before_rendering_page do |page|
    page.row(0).border_top_width = 3
    page.row(-1).border_bottom_width = 3
    page.column(0).border_left_width = 3
    page.column(-1).border_right_width = 3
    end
   end


  # rowCounter += 1
  # if(rowCounter == 3)
  #   move_down 20
  # end
end