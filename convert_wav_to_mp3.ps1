$ffmpegPath = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue

if (-not $ffmpegPath) {
    Write-Host "FFmpeg not found. Installing FFmpeg using winget..."
    winget install ffmpeg

    $ffmpegPath = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue

    if (-not $ffmpegPath) {
        Write-Host "FFmpeg installation failed. Install FFmpeg manually."
        Exit 1
    }
}


$work_dir = ".\"	# path\to\folders\

"Getting Folders..."
$folders = Get-ChildItem -Path $work_dir -Directory		# store every folder in a list

foreach ($folder in $folders)
{	
	"Getting .wavs..."
	$wavs_all = Get-ChildItem -Path $folder -File "*.wav"	# store every .wav in the current folder
	$wavs
	
	if ($wavs_all.Count -lt 2)					# skip processing in case there are less than two elements
	{
		continue
	}
	else
	{
		$wavs = $wavs_all
	}

	
	$year = "0000"
	$month = "00"
	$day = "00"

	$output_path_archive = ".\$($folder)\archiv\"	# .\2023.08.27\archiv\
	$output_path_predigt = ".\$($folder)\predigt\"	# .\2023.08.27\predigt\

	# create directories for archive and predigt in case they do not already exist
	if (!(Test-Path -Path $output_path_archive))
	{
		mkdir $output_path_archive	# create directory 
	}

	if (!(Test-Path -Path $output_path_predigt))
	{
		mkdir $output_path_predigt	# create directory 
	}

	"Converting wav to mp3..."
	$i = 1
	foreach ($wav in $wavs)
	{
		if ($wav.FullName -match "(?<year>\d{4})\.(?<month>\d{2})\.(?<day>\d{2})")	# regex expression that finds the date in the path of the .wav
		{
			$year = $matches.year
			$month = $matches.month
			$day = $matches.day
		}
		else
		{
			"Did not find any date in $($wav.Name)"
			break	# skip to next .wav
		}
		
		$filename_archive = "$($year)$($month)$($day)_$i"			# 20230827_1
		$filename_predigt = "$($year)$($month)$($day)"				# 20230827
		
		$in = ".\$($folder)\$($wav)"								# .\2023.08.27\001.wav
		$out = "$($output_path_archive)$($filename_archive).mp3"	# .\2023.08.27\mp3\20230827_1.mp3
																	# converted files are stored in a folder "archiv" inside every day
		
		ffmpeg -i $in -vn -ar 44100 -ac 2 -b:a 192k $out			# basic conversion

		# assuming that the predigt is the second element, copy it to the respective folder
		if ($i -eq 2) 
		{
			$out_predigt = "$($output_path_predigt)$($filename_predigt).mp3"
			Copy-Item -Path $out -Destination $out_predigt						# Copy the file and rename it
		}

		$i++														# increase counter
	}
	"Finished converting."
}

