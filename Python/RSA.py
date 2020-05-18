#!/usr/bin/env python
# RSA algorithm realization using Python3
#	Yijiang Chen. 2020.5.18

#	libs need: rsa OR pycryptodome
#		>pip install rsa/pip install pycryptodome

import rsa
import base64

def decode_base64(data):
    """Decode base64, padding being optional.

    :param data: Base64 data as an ASCII byte string
    :returns: The decoded byte string.

    """
    missing_padding = len(data) % 4
    if missing_padding != 0:
        data += b'='* (4 - missing_padding)
    return base64.decodestring(data)

def rsaEncrypt(Plaintext,pubKey):
	'''
	@ content:
	@ pubKey:
	@ return:Ciphertext
	'''
	Plaintext = Plaintext.encode('utf-8')
	Ciphertext = rsa.encrypt(Plaintext,pubKey)

	return Ciphertext

def rsaDecrypt(Ciphertext,privKey):
	'''
	@ Ciphertext:
	@ privKey:
	@ result:
	'''
	Ciphertext = decode_base64(Ciphertext)
	Plaintext = rsa.decrypt(Ciphertext,privKey).decode('utf-8')
	Plaintext = Plaintext.decode('utf-8')

	return Plaintext


if __name__=='__main__':

	plaintext = 'mess'
	signImfo = 'Sign'
	#generate keys.
	(pubkey_A,privkey_A)=rsa.newkeys(1024)
	(pubkey_B,privkey_B)=rsa.newkeys(1024)
	# save publicKey information.
	#filename = 'publicKey_A.pem'
	#save(pubkey_A,filename)

	#--------------Encrypt---------------
	ciphertext = rsaEncrypt(plaintext,pubkey_B)
	#-------------Signature--------------
	signature =  rsa.sign(signImfo.encode(),privkey_A,'MD5')

	#print all the information
	print('----------------User A: Encrypt----------------')
	print('plaintext:',plaintext,'  ','pubkey of B:',pubkey_B)
	print('ciphertext generated:',ciphertext)
	print('signature:',signature)
	print('-----------------------------------------------')


	#------------------Decrypt-------------------
	plaintext_re = rsaDecrypt(ciphertext,privkey_B)
	sig = rsa.verify(signImfo,signature,pubkey_A)
	

	#print all the information
	print('----------------User B: Decrypt----------------')
	print('ciphertext:',ciphertext,'  ','pubkey of A:',pubkey_A)
	print('plaintext decrypted:',plaintext)
	print('verified?:',bool(sig))
	print('------------------------------------------------')
	