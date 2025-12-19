extends Node

enum Mode{INFO,DEBUG,ERROR,NONE}

var fileName : String = Time.get_time_string_from_system() + ".log"
var folderName : String = Time.get_date_string_from_system() + "/"
var loggingFolder : String = "user://custom-logs/"
var printMode : Mode = Mode.INFO
var fileMode : Mode = Mode.DEBUG

var file : FileAccess

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(loggingFolder + folderName):
		DirAccess.make_dir_recursive_absolute(loggingFolder + folderName)
	file = FileAccess.open(loggingFolder + folderName + fileName, FileAccess.ModeFlags.WRITE)
	clean_logs()

func clean_logs() -> void:
	var logFolder := DirAccess.open(loggingFolder)
	for directory : String in logFolder.get_directories():
		if (directory + "/") != folderName:
			for f in DirAccess.open(loggingFolder + directory).get_files():
				logFolder.remove(directory + "/" + f)
			logFolder.remove(directory)

func info(msg : String):
	msg = "INFO: " + msg
	if printMode <= Mode.INFO: print(msg)
	if fileMode <= Mode.INFO: save(msg)

func debug(msg : String):
	msg = "DEBUG: " + msg
	if printMode <= Mode.DEBUG: print(msg)
	if fileMode <= Mode.DEBUG: save(msg)

func error(msg : String):
	msg = "ERROR: " + msg
	if printMode <= Mode.ERROR: print(msg)
	if fileMode <= Mode.ERROR: save(msg)

func save(msg : String):
	file.store_line(msg)
