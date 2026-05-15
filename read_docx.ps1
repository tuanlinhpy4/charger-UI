$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Open("C:\Users\DELL\Desktop\ev_charger_ui\2023.2_LTM2_GK02_De01_GiaiChiTiet.docx")
$doc.Content.Text
$doc.Close()
$word.Quit()
