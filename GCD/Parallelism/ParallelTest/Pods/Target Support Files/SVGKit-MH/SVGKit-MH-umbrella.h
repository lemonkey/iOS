#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SVGKImage.h"
#import "SVGKit.h"
#import "SVGKSource.h"
#import "AppleSucksDOMImplementation.h"
#import "Attr.h"
#import "CDATASection.h"
#import "CharacterData.h"
#import "Comment.h"
#import "CSSPrimitiveValue.h"
#import "CSSPrimitiveValue_ConfigurablePixelsPerInch.h"
#import "CSSRule.h"
#import "CSSRuleList+Mutable.h"
#import "CSSRuleList.h"
#import "CSSStyleDeclaration.h"
#import "CSSStyleRule.h"
#import "CSSStyleSheet.h"
#import "CSSValue.h"
#import "CSSValueList.h"
#import "CSSValue_ForSubclasses.h"
#import "Document+Mutable.h"
#import "Document.h"
#import "DocumentCSS.h"
#import "DocumentFragment.h"
#import "DocumentStyle.h"
#import "DocumentType.h"
#import "DOMGlobalSettings.h"
#import "DOMHelperUtilities.h"
#import "Element.h"
#import "EntityReference.h"
#import "MediaList.h"
#import "NamedNodeMap.h"
#import "NamedNodeMap_Iterable.h"
#import "Node+Mutable.h"
#import "Node.h"
#import "NodeList+Mutable.h"
#import "NodeList.h"
#import "ProcessingInstruction.h"
#import "StyleSheet.h"
#import "StyleSheetList+Mutable.h"
#import "StyleSheetList.h"
#import "Text.h"
#import "SVGAngle.h"
#import "SVGAnimatedPreserveAspectRatio.h"
#import "SVGClipPathElement.h"
#import "SVGDefsElement.h"
#import "SVGDocument.h"
#import "SVGDocument_Mutable.h"
#import "SVGElementInstance.h"
#import "SVGElementInstanceList.h"
#import "SVGElementInstanceList_Internal.h"
#import "SVGElementInstance_Mutable.h"
#import "SVGFitToViewBox.h"
#import "SVGGElement.h"
#import "SVGHelperUtilities.h"
#import "SVGLength.h"
#import "SVGMatrix.h"
#import "SVGNumber.h"
#import "SVGPoint.h"
#import "SVGPreserveAspectRatio.h"
#import "SVGRect.h"
#import "SVGStylable.h"
#import "SVGSVGElement_Mutable.h"
#import "SVGTextContentElement.h"
#import "SVGTextPositioningElement.h"
#import "SVGTextPositioningElement_Mutable.h"
#import "SVGTransform.h"
#import "SVGTransformable.h"
#import "SVGUnitTypes.h"
#import "SVGUseElement.h"
#import "SVGUseElement_Mutable.h"
#import "SVGViewSpec.h"
#import "BaseClassForAllSVGBasicShapes.h"
#import "BaseClassForAllSVGBasicShapes_ForSubclasses.h"
#import "ConverterSVGToCALayer.h"
#import "SVGCircleElement.h"
#import "SVGDescriptionElement.h"
#import "SVGElement.h"
#import "SVGElement_ForParser.h"
#import "SVGEllipseElement.h"
#import "SVGGradientElement.h"
#import "SVGGradientStop.h"
#import "SVGGroupElement.h"
#import "SVGImageElement.h"
#import "SVGLineElement.h"
#import "SVGPathElement.h"
#import "SVGPolygonElement.h"
#import "SVGPolylineElement.h"
#import "SVGRectElement.h"
#import "SVGStyleCatcher.h"
#import "SVGStyleElement.h"
#import "SVGSVGElement.h"
#import "SVGSwitchElement.h"
#import "SVGTextElement.h"
#import "SVGTitleElement.h"
#import "TinySVGTextAreaElement.h"
#import "CALayerExporter.h"
#import "SVGKExporterNSData.h"
#import "SVGKExporterUIImage.h"
#import "SVGKImage+CGContext.h"
#import "SVGKParserDefsAndUse.h"
#import "SVGKParserDOM.h"
#import "SVGKParserGradient.h"
#import "SVGKParserPatternsAndGradients.h"
#import "SVGKParserStyles.h"
#import "SVGKParserSVG.h"
#import "SVGKParser.h"
#import "SVGKParseResult.h"
#import "SVGKParserExtension.h"
#import "SVGKPointsAndPathsParser.h"
#import "CALayer+RecursiveClone.h"
#import "CALayerWithChildHitTest.h"
#import "CALayerWithClipRender.h"
#import "CAShapeLayerWithClipRender.h"
#import "CAShapeLayerWithHitTest.h"
#import "CGPathAdditions.h"
#import "SVGGradientLayer.h"
#import "SVGKLayer.h"
#import "SVGKSourceLocalFile.h"
#import "SVGKSourceNSData.h"
#import "SVGKSourceString.h"
#import "SVGKSourceURL.h"
#import "NSCharacterSet+SVGKExtensions.h"
#import "NSData+NSInputStream.h"
#import "SVGKFastImageView.h"
#import "SVGKImageView.h"
#import "SVGKLayeredImageView.h"
#import "SVGKPattern.h"
#import "SVGUtils.h"

FOUNDATION_EXPORT double SVGKit_MHVersionNumber;
FOUNDATION_EXPORT const unsigned char SVGKit_MHVersionString[];

