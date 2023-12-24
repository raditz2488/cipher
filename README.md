# cipher

A cli tool to quickly cipher and decipher text files using a password and **AES Encryption** and Decryption.

## How to use?

### Using the package directly:

We need to use `swift run` to build and execute the command everytime. Also note that the input files should exist in the package's root folder.

#### Encrypt

`swift run cipher <REPLACE_WITH_PASSWORD> -i <InFile> -o <OutFile>`

Eg: 

`swift run cipher sdfg123 -i Sample.txt -o SampleEncrypted.txt`

#### Decrypt

`swift run cipher <REPLACE_WITH_PASSWORD> -i <InFile> -o <OutFile> -d` 

Eg:

`swift run cipher sdfg123 -i SampleEncryped.txt -o SampleDecrypted.txt -d`

### Execute the command from anywhere:

You might wonder can we not use `swift run` before the `cipher` command. The answer is yes. In order to do that you need to make the cipher command available to global level. Here you can go to any folder and encrypt and decrypt any text files

#### Here's how to do that:
* Build the package for release
  * `swift build --configuration release`
* Copy the build to the bin folder
  * `cp -f .build/release/cipher /usr/local/bin/cipher`

Now you can use the following commands without `swift run`

#### Encrypt

`cipher <REPLACE_WITH_PASSWORD> -i <InFile> -o <OutFile>`

Eg: 

`cipher sdfg123 -i Sample.txt -o SampleEncrypted.txt`

#### Decrypt

`cipher <REPLACE_WITH_PASSWORD> -i <InFile> -o <OutFile> -d` 

Eg:

`cipher sdfg123 -i SampleEncryped.txt -o SampleDecrypted.txt -d`
