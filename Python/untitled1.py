#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May 14 15:10:09 2020

@author: jamie
"""

def validate_base_sequence(base_sequence, RNAflag = False):
    """Return True if the string base_sequence contains only upper- or lowercase T 
    (or U, if RNAflag), C, A, and G characters, otherwise False"""
    seq = base_sequence.upper()
    return len(seq) == (seq.count('U' if RNAflag else 'T') +
                        seq.count('C') + seq.count('A') + seq.count('G'))
def gc_content(base_seq):
    """Return the percentage of bases in base_seq that are C or G""" 
    assert validate_base_sequence(base_seq), \
    'argument has invalid characters' 
    return (base_seq.count('G') + base_seq.count('C')) / len(base_seq)
def recognition_site(base_seq, recognition_seq): 
    """Return the first position in base_seq where recognition_seq occurs, or −1 if not found"""
    return base_seq.find(recognition_seq)
def test():
    assert validate_base_sequence('ACTG') 
    assert validate_base_sequence('')
    assert not validate_base_sequence('ACUG')
    assert .5 == gc_content('ACTG') 
    assert 1.0 == gc_content('CCGG') 
    assert .25 == gc_content('ACTT')

print('All tests passed.') 

test()

RNA_codon_table = {'CUU': 'Leu', 'UAG': '---', 'ACA': 'Thr', 'AAA': 'Lys', 'AUC': 'Ile', 'AAC ': 'Asn', 'AUA': 'Ile', 'AGG': 'Arg', 'CCU': 'Pro', 'ACU': 'Thr', 'AGC': 'S er', 'AAG': 'Lys', 'AGA': 'Arg', 'CAU': 'His', 'AAU': 'Asn', 'AUU': 'Ile', 'CUG': 'Leu', 'CUA': 'Leu', 'CUC': 'Leu', 'CAC': 'His', 'UGG': 'Trp', 'CAA' : 'Gln', 'AGU': 'Ser', 'CCA': 'Pro', 'CCG': 'Pro', 'CCC': 'Pro', 'UAU': 'Ty r', 'GGU': 'Gly', 'UGU': 'Cys', 'CGA': 'Arg', 'CAG': 'Gln', 'UCU': 'Ser', ' GAU': 'Asp', 'CGG': 'Arg', 'UUU': 'Phe', 'UGC': 'Cys', 'GGG': 'Gly', 'UGA':'---', 'GGA': 'Gly', 'UAA': '---', 'ACG': 'Thr', 'UAC': 'Tyr', 'UUC': 'Phe ', 'UCG': 'Ser', 'UUA': 'Leu', 'UUG': 'Leu', 'UCC': 'Ser', 'ACC': 'Thr', 'UCA': 'Ser', 'GCA': 'Ala', 'GUA': 'Val', 'GCC': 'Ala', 'GUC': 'Val', 'GGC': 'Gly', 'GCG': 'Ala', 'GUG': 'Val', 'GAG': 'Glu', 'GUU': 'Val', 'GCU': 'Ala' , 'GAC': 'Asp', 'CGU': 'Arg', 'GAA': 'Glu', 'AUG': 'Met', 'CGC': 'Arg'}
    
from pprint import pprint
pprint(RNA_codon_table)

def translate_RNA_codon(codon): 
    return RNA_codon_table[codon]

translate_RNA_codon('UCC')

RNA_codon_table.get('UCC')

def read_FASTA(filename):
    with open(filename) as file:
        return file.read().split('>')[1:]
    
def read_FASTA_sequences_and_info(filename): 
    """• Split the file contents at '>' to get a list of strings representing entries
• Partition the strings to separate the first line from the rest
• Remove the useless '>' from the resulting triples
• Remove the newlines from the sequence data
• Split the description line into pieces where vertical bars appear"""
    return [[seq[0].split('|'), seq[1]] for seq in 
            read_FASTA_sequences(filename)]



def generate_triples(chars='TCAG'):
    """Return a list of all three-character combinations of unique characters in chars""" 
    chars = set(chars)
    return [b1 + b2 + b3 for b1 in chars for b2 in chars for b3 in chars]