module InvoicesHelper

  def exporting_check(invoice, allowed=false)
    if allowed
      content_tag :td do
        check_box_tag nil, invoice.id, false, class: "invoice-id"
      end
    end
  end

  def exporting_header(allowed=false)
    if allowed
      content_tag :th do
        check_box_tag nil, nil, false, class: "select-all"
      end
    end
  end

  def exporting_button(allowed=false)
    # .pull-right
    # a.btn.btn-primary onclick="exportIif()" Export to IFF
    if allowed
      content_tag :div, class: "pull-right" do
        link_to "Export to IFF", "#", onclick: "exportIif()", class: "btn btn-primary"
      end
    end
  end
end