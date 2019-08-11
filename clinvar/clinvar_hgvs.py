import os.path

from lxml import etree

import hgvs.parser
from hgvs.exceptions import HGVSParseError
from hgvs.parser import Parser 

HGVSParser = Parser()


# Save metrics for questionable hgvs strings...
hgvs_snafu_header = 'hgvs_text\terror_msg'

fh = open('hgvs_snafus.tsv', 'w')
fh.write(hgvs_snafu_header + '\n')

def write_hgvs_snafu(hgvs, error):
    fh.write('"{}"\t"{}"\n'.format(hgvs, error))
    fh.flush()


def get_hgvs_from_clinvarset(elem):
    """
    Gets HGVS strings from a ClinVarSet element

    :param elem: ClinVarSet
    :return: List of HGVS strings
    """
    hgvs = []
    attributes = elem.xpath("ReferenceClinVarAssertion//Attribute[contains(@Type,'HGVS')]")
    for e in attributes:
        hgvs_text = e.text.replace('"', '')
        try:
            hgvs_text = str(HGVSParser.parse_hgvs_variant(hgvs_text))
        except HGVSParseError as err:
            write_hgvs_snafu(hgvs_text, err)
        hgvs.append(hgvs_text)
    if len(hgvs) == 0:
        hgvs.append('')
    return hgvs


def get_variantid_from_clinvarset(elem):
    """
    Gets variant ID from a ClinVarSet Element

    :param elem:  ClinVarSet
    :return:      Variant ID
    """
    try:
        # return elem.xpath("ReferenceClinVarAssertion//MeasureSet[@Type='Variant']")[0].attrib['ID']
        if elem.find('ReferenceClinVarAssertion').find('MeasureSet') is not None:
            out = elem.find('ReferenceClinVarAssertion').find('MeasureSet').attrib['ID']
        elif elem.find('ReferenceClinVarAssertion').find('GenotypeSet') is not None:
            out = elem.find('ReferenceClinVarAssertion').find('GenotypeSet').find('MeasureSet').attrib['ID']
        else:
            out = ''
        return out
    except:
        return ''


def get_clinvar_accession_from_clinvarset(elem):
    """
    Gets the Clinvar accession from a ClinVarSet element

    :param elem: ClinVarSet Element
    :return: ClinVar Accession
    """
    ## elem.xpath("//ClinVarAccession")[0].attrib['Acc'] ## this only works sometimes
    try:
        # return elem.xpath("//ClinVarAccession")[0].attrib['Acc'] ## this only works sometimes
        out = elem.find("ReferenceClinVarAssertion").find("ClinVarAccession").attrib['Acc']
        if out is None:
            out = ''
        return out
    except:
        return ''


def get_alleleid_from_clinvarset(elem):
    """
    Gets the allele ID from a ClinVarSet element in Clinvar XML

    :param elem: ClinVarSet xml element
    :return: AlleleId
    """

    try:
        if elem.find('ReferenceClinVarAssertion').find('MeasureSet') is not None:
            out = elem.find('ReferenceClinVarAssertion').find('MeasureSet').find('Measure').attrib['ID']
        elif elem.find('ReferenceClinVarAssertion').find('GenotypeSet') is not None:
            out = elem.find('ReferenceClinVarAssertion').find('GenotypeSet').find('MeasureSet').find('Measure').attrib['ID']
        else:
            out = ''
        return out
    except:
        return ''


if __name__ == '__main__':

    debug = True

    mirror_dir = os.path.dirname( os.path.realpath(__file__) ) + "/mirror/"
    xml = mirror_dir + "/ClinVarFullRelease_00-latest.xml"
    # xml = mirror_dir + "/test.xml"

    context = etree.iterparse(xml, events=('start', 'end'))
    context = iter(context)
    event, root = next(context)
    print("Parsing Clinvar XML -- please wait.")
    with open( mirror_dir + "/clinvar_hgvs.tsv", 'w' ) as f:

        ## get each record
        for event, elem in context:
            if event == "end" and elem.tag == 'ClinVarSet':
                variantID = get_variantid_from_clinvarset(elem)
                alleleID = get_alleleid_from_clinvarset(elem)
                hgvs_list = get_hgvs_from_clinvarset(elem)
                clinvarAccession = get_clinvar_accession_from_clinvarset( elem )
                for hgvs_text in hgvs_list:
                    f.write("%s\t%s\t%s\t%s\n"% (variantID, alleleID, clinvarAccession, hgvs_text))
                root.clear()

