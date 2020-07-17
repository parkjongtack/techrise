/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */



CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	
	  config.toolbar = [
    	{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source' ] },
			{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat' ] },
    	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent','-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-' ] },
    	{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
			{ name: 'insert', items: [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar' ] },
    	{ name: 'styles', items: [  'FontSize' ] },
    	{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    	{ name: 'others', items: [ '-' ] },
    	
    ];
    config.wordcount = {
        // Whether or not you want to show the Paragraphs Count
        showParagraphs: false,

        // Whether or not you want to show the Word Count
        showWordCount: false,
    
        // Whether or not you want to show the Char Count
        showCharCount: false,
    
        // Whether or not you want to count Spaces as Chars
        countSpacesAsChars: false,
    
        // Whether or not to include Html chars in the Char Count
        countHTML: false,
        
        // Maximum allowed Word Count, -1 is default for unlimited
        maxWordCount: -1,
    
        // Maximum allowed Char Count, -1 is default for unlimited
        maxCharCount: -1,
    
        // Add filter to add or remove element before counting (see CKEDITOR.htmlParser.filter), Default value : null (no filter)
        /* filter: new CKEDITOR.htmlParser.filter({
            elements: {
                div: function( element ) {
                    if(element.attributes.class == 'mediaembed') {
                        return false;
                    }
                }
            }
        }) */
				
				
				
    };

		config.removePlugins = 'elementspath'; 
		config.toolbarCanCollapse = false; 
		config.filebrowserUploadMethod = 'form'; 
	  config.filebrowserImageUploadUrl = '/upload/upload.asp';
		



	

		
	
/*     config.toolbar = [
    	{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source', '-', 'Save', 'NewPage', 'Preview', 'Print', '-', 'Templates' ] },
    	{ name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
    	{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
    	{ name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
    	'/',
    	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat' ] },
    	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
    	{ name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
    	{ name: 'insert', items: [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe' ] },
    	'/',
    	{ name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
    	{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    	{ name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] },
    	{ name: 'others', items: [ '-' ] },
    	
    ];
    
    
    config.toolbarGroups = [
    	{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
    	{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
    	{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ] },
    	{ name: 'forms' },
    	'/',
    	{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    	{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
    	{ name: 'links' },
    	{ name: 'insert' },
    	'/',
    	{ name: 'styles' },
    	{ name: 'colors' },
    	{ name: 'tools' },
    	{ name: 'others' },
    	{ name: 'about' }
    ]; */


};
