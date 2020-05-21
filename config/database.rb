Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
when :development then Sequel.connect("postgres://postgres:22021997@localhost/bossgame_game25_backoffice_dev", :loggers => [logger])
when :production  then Sequel.connect("postgres://postgres:22021997@localhost/bossgame_game25_backoffice_prod",  :loggers => [logger])
when :test        then Sequel.connect("postgres://postgres:22021997@localhost/bossgame_game25_backoffice_test",        :loggers => [logger])
end
Sequel::Model.db.extension(:pagination)
