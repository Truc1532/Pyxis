echo "Which EL to boot in"
echo "1: EL1"
echo "2: EL2"
echo "3: EL3"

read -p ">" choice

if [ "$choice" = "1" ]; then
	qemu-system-aarch64 -m 128M -M virt -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.elf
elif [ "$choice" = "2" ]; then       
	qemu-system-aarch64 -m 128M -M virt,virtualization=on -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.elf
elif [ "$choice" = "3" ]; then
	qemu-system-aarch64 -m 128M -M virt,secure=on -cpu cortex-a53 -nographic -serial mon:stdio -kernel kernel.elf
else 
	echo "unknown option"
	exit 1
fi
