<template>
	<v-flex xs12>
		Carateres disponibles: {{4000000000-$store.state.contenidoEditor.length}}
		<quill-editor ref="myTextEditor" v-model="$store.state.contenidoEditor" :options="editorOption">
		</quill-editor>
	</v-flex>
</template>

<script>
	import Quill from 'quill'
	import { ImageDrop } from 'quill-image-drop-module'
	import ImageResize from 'quill-image-resize-module'
	Quill.register('modules/imageDrop', ImageDrop)
	Quill.register('modules/imageResize', ImageResize)
	export default {
		created () {
			this.$store.state.contenidoEditor= '<h2 class="ql-align-center"><span class="ql-font-serif">Introduzca el texto...</span></h2>';
		},
		data() {
			return {
				editorOption: {
					modules: {
						toolbar: [
							['bold', 'italic', 'underline', 'strike'],
							['blockquote'],
							[{
								'header': 1
							}, {
								'header': 2
							}],
							[{
								'list': 'ordered'
							}, {
								'list': 'bullet'
							}],
							[{
								'script': 'sub'
							}, {
								'script': 'super'
							}],
							[{
								'indent': '-1'
							}, {
								'indent': '+1'
							}],
							[{
								'direction': 'rtl'
							}],
							[{
								'size': ['small', false, 'large', 'huge']
							}],
							[{
								'header': [1, 2, 3, 4, 5, 6, false]
							}],
							[{
								'font': []
							}],
							[{
								'color': []
							}, {
								'background': []
							}],
							[{
								'align': []
							}],
							['clean'],
							['link', 'image', 'video']
						],
						imageDrop: true,
						imageResize: {
							displayStyles: {
								backgroundColor: 'black',
								border: 'none',
								color: 'white'
							},
							modules: ['Resize', 'DisplaySize', 'Toolbar']
						}
					}
				}
			}
		},
	}
</script>

<style lang="scss" scoped>
	.quill-code {
		border: none;
		height: auto;

		>code {
			width: 100%;
			margin: 0;
			padding: 1rem;
			border: 1px solid #ccc;
			border-top: none;
			border-radius: 0;
			height: 10rem;
			overflow-y: auto;
			resize: vertical;
		}
	}
</style>