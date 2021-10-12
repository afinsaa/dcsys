

prawn_document do |pdf|
  pdf.font Rails.root.join('app/assets/fonts/GE_SS_Unique_Light.otf')
  # pdf.font.size = 13
  pdf.text ("- منصة حصين - #{current_user.school.name}").fix_arabic_glyphs, :position => :center
  pdf.font "Helvetica"
  pdf.move_down 20
  # pdf.table [['d']]
  # pdf.table @logs.collect{|p| [p.student.sid,p.student.name, p.tawaklna_s]}
  studArray = []
  rowCounter = 0
  @students.each do |s|
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

    nameCell = pdf.make_cell(content: s.name.fix_arabic_glyphs, borders: [], size: 10, :text_color => "000000", padding: [0,5,5,0], font: Rails.root.join('app/assets/fonts/GE_SS_Unique_Light.otf'))
    sCard = [
      [
        s.sid
       
      ],
      [
         {:image => fUrl, width: 50, :position => :center}
      ],
      [
        nameCell
      ]
    ]
    newS = pdf.make_table(sCard, :cell_style => {:padding => [20, 20, 20, 20], width: 170, :borders => [ ] } , :position => :center)
    
    if studArray.count > 0
      arr = studArray.last
      if arr.count < 3
        arr.append(newS)
        studArray.pop()
        studArray.append(arr)
      else
        arr = [newS]
        studArray.append(arr)
      end
    else
      arr = [newS]
      studArray.append(arr)
    end
  end
  # pdf.table(@students.collect{|p| [p.student.sid,p.student.name, p.tawaklna_s, p.created_at.to_s]}, header: true)
  # pdf.table(studArray, :cell_style => { :borders => [:top, :left]})

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