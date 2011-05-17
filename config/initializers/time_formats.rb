Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%b %d, %Y")}
Time::DATE_FORMATS[:pretty_input] = lambda { |time| time.strftime("%d %m, %Y")}
