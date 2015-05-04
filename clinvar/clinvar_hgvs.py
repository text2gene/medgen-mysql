from lxml import etree
from lxml import objectify
import os.path


def get_hgvs_from_clinvarset( elem ):
    hgvs = []
    attributes = elem.xpath("ReferenceClinVarAssertion//Attribute[contains(@Type,'HGVS')]")
    for e in attributes:
        hgvs.append(e.text)
    return hgvs


def get_variantid_from_clinvarset( elem ):
    try:
        # return elem.xpath("ReferenceClinVarAssertion//MeasureSet[@Type='Variant']")[0].attrib['ID']
        return elem.find('ReferenceClinVarAssertion').find('MeasureSet').attrib['ID']
    except:
        return ''


def get_clinvar_accession_from_clinvarset( elem ):
    ## elem.xpath("//ClinVarAccession")[0].attrib['Acc'] ## this only works sometimes
    try:
        # return elem.xpath("//ClinVarAccession")[0].attrib['Acc'] ## this only works sometimes
        return elem.find("ReferenceClinVarAssertion").find("ClinVarAccession").attrib['Acc']
    except:
        return ''


def get_alleleid_from_clinvarset( elem ):
    try:
        return elem.find('ReferenceClinVarAssertion').find('MeasureSet').find('Measure').attrib['ID']
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

    with open( mirror_dir + "/clinvar_hgvs.tsv", 'w' ) as f:
        ## get each record
        for event, elem in context:
            if event == "end" and elem.tag == 'ClinVarSet':
                variantID = get_variantid_from_clinvarset(elem)
                alleleID = get_alleleid_from_clinvarset(elem)
                hgvs = get_hgvs_from_clinvarset(elem)
                clinvarAccession = get_clinvar_accession_from_clinvarset( elem )
                for h in hgvs:
                    f.write( "%s\t%s\t%s\t%s\n"% (variantID, alleleID, clinvarAccession, h) )
                root.clear()
