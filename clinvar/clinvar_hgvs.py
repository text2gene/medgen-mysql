from lxml import etree
import os.path


def get_hgvs_from_clinvarset( elem ):
    """
    Gets HGVS strings from a ClinVarSet element
    :param elem: ClinVarSet
    :return: List of HGVS strings
    """
    hgvs = []
    attributes = elem.xpath("ReferenceClinVarAssertion//Attribute[contains(@Type,'HGVS')]")
    for e in attributes:
        hgvs.append(e.text)
    if len(hgvs) == 0:
        hgvs.append('')
    return hgvs


def get_variantid_from_clinvarset( elem ):
    """
    Gets variant ID from a ClinVarSet Element
    :param elem: ClinVarSet
    :return:    Variant ID
    """
    try:
        # return elem.xpath("ReferenceClinVarAssertion//MeasureSet[@Type='Variant']")[0].attrib['ID']
        out = elem.find('ReferenceClinVarAssertion').find('MeasureSet').attrib['ID']
        if out is None:
            out = ''
        return out
    except:
        return ''


def get_clinvar_accession_from_clinvarset( elem ):
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


def get_alleleid_from_clinvarset( elem ):
    """
    Gets the allele ID from a ClinVarSet element in Clinvar XML
    :param elem: ClinVarSet xml element
    :return: AlleleId
    """

    try:
        out = elem.find('ReferenceClinVarAssertion').find('MeasureSet').find('Measure').attrib['ID']
        if out is None:
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
    event, root = context.next()
    print "Parsing Clinvar XML -- please wait."
    with open( mirror_dir + "/clinvar_hgvs.tsv", 'w' ) as f:
        ## get each record
        for event, elem in context:
            if event == "end" and elem.tag == 'ClinVarSet':
                variantID = get_variantid_from_clinvarset(elem)
                alleleID = get_alleleid_from_clinvarset(elem)
                hgvs = get_hgvs_from_clinvarset(elem)
                clinvarAccession = get_clinvar_accession_from_clinvarset( elem )
                for h in hgvs:
                    h = h.replace('"', '')
                    f.write( "%s\t%s\t%s\t%s\n"% (variantID, alleleID, clinvarAccession, h) )
                root.clear()
