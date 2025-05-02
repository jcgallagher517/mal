
def pr_list(sexp)
  print "("
  sexp.each_with_index do |item, i|
    if item.is_a?(Array)
      pr_list(item)
    else
      print item.to_s
    end
    if not sexp[i+1].nil?
      print " "
    end
  end
  print ")"
end

def pr_str(mal_form)
  if mal_form.is_a?(Array)
    pr_list(mal_form)
  else
    print mal_form.to_s
  end
  puts
end
