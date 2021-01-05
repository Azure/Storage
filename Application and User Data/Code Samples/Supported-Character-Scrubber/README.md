# Azure Storage Supported Character Scrubber

Azure Storage supports a wide variety of Unicode characters across containers, blobs, metadata, and snapshots. When you are migrating from another storage system to Azure, you may find that some characters supported in your source system (*e.g.,* AWS S3) are not supported by Azure and will require an object to be renamed.

The PowerShell script [AzureStorageSupportedCharacterScrubber.ps1](AzureStorageSupportedCharacterScrubber.ps1) provides a turnkey solution to discovering unsupported characters in your file names with a simple CSV input. If you choose to rename your files to conform to Azure blob storage, you can also choose to create a mapping CSV output which can be used create your objects with a new destination file name (if required).

To leverage the script, you can download the sample input CSV ([SourceFileNames.csv](SourceFileNames.csv)). This file contains a single column, `SourceFileName`. The PowerShell script will evaluate each row in the CSV and optionally create a new mapping file ([FixedFileNames.csv](FixedFileNames.csv)) which provides alternative names by replacing unsupported characters with a valid character of your choosing.

## Usage

```powershell
.\AzureStorageSupportedCharacterScrubber.ps1 -CsvInputPath .\SourceFileNames.csv -RenameItems
```

## Sample input

| SourceFileName |
| --- |
| BadChaÄracter in the name.pdf |

## Sample output

### Shell

```powershell
ReplacementString not provided, using default as ''
Testing character B (CodePoint: 66)
Testing character a (CodePoint: 97)
Testing character d (CodePoint: 100)
Testing character C (CodePoint: 67)
Testing character h (CodePoint: 104)
Testing character a (CodePoint: 97)
Testing character Ä (CodePoint: 196)
Testing character  (CodePoint: 141)
Unsupported char code point: 141
Testing character r (CodePoint: 114)
Testing character a (CodePoint: 97)
Testing character c (CodePoint: 99)
Testing character t (CodePoint: 116)
Testing character e (CodePoint: 101)
Testing character r (CodePoint: 114)
Testing character   (CodePoint: 32)
Testing character i (CodePoint: 105)
Testing character n (CodePoint: 110)
Testing character   (CodePoint: 32)
Testing character t (CodePoint: 116)
Testing character h (CodePoint: 104)
Testing character e (CodePoint: 101)
Testing character   (CodePoint: 32)
Testing character n (CodePoint: 110)
Testing character a (CodePoint: 97)
Testing character m (CodePoint: 109)
Testing character e (CodePoint: 101)
Testing character . (CodePoint: 46)
Testing character p (CodePoint: 112)
Testing character d (CodePoint: 100)
Testing character f (CodePoint: 102)
Source name:      BadChaÄracter in the name.pdf
Destination name: BadCharacter in the name.pdf
```

### CSV

| SourceFileName | DestinationFileName |
| --- | --- |
| BadChaÄracter in the name.pdf | BadCharacter in the name.pdf |

## Disallowed Characters

The following is a quick list of illegal characters. Note this is not an exhaustive list which the script provides.

| Character | Code Point | Description |
| --- | --- | --- |
| * | 0x0000002A | |
| " | 0x00000022 | Quotation mark |
| ? | 0x0000003F | Question mark |
| > | 0x0000003E | Greater than |
| < | 0x0000003C | Less than |
| : | 0x0000003A | Colon |
| \| | | 0x0000007C | |
| / | 0x0000002F | Forward slash |
| \ | 0x0000005C | Backslash |
| del | 0x0000007F | Delete |
| | 0x00000081| High octet preset |
| | 0x0000008D | Ri reverse line feed |
| | 0x0000008F | ss3 single shift three |  
| | 0x00000090 | dcs device control string |
| | 0x0000009D | osc operating system command |

## Resources

- [Naming and Referencing Containers, Blobs, and Metadata](https://docs.microsoft.com/rest/api/storageservices/naming-and-referencing-containers--blobs--and-metadata)
- [RFC 2616](https://www.ietf.org/rfc/rfc2616.txt)
- [RFC 3987](https://www.ietf.org/rfc/rfc3987.txt)
- [Unicode characters](https://www.fileformat.info/info/unicode/)